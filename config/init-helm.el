;; I used to use ido for everything, but now I've almost exclusively switched
;; to helm (https://github.com/emacs-helm/helm).  The biggest blocker was its
;; find-files functionality, which is... quirky by default... and ido has one
;; that is basically world-class in terms of quickly zipping through directory
;; hierarchies.  The last few defuns/bindings rectify the biggest issues I had
;; with helm-find-files and make it quite usable for me.

;; http://tuhdo.github.io/helm-intro.html is a pretty good tutorial followed
;; by an exhaustive listing of all the cool stuff you can do with it.  Helm is
;; a lot like Unite in Vim:  both provide consistent interfaces to a bunch of
;; disparate functionality in their respective editors.

(use-package helm
  :ensure t
  :init (require 'helm-config)
  :config
  (progn
    (helm-mode 1)
    (helm-adaptive-mode)

    (setq helm-ff-file-name-history-use-recentf t
	  helm-buffers-fuzzy-matching t)

    (after 'diminish
      (diminish 'helm-mode))

    ;;; keybindings used by helm itself
    ;; swaps C-z and <tab> -- this makes helm-find-files INFINITELY more usable
    ;; cheers to http://tuhdo.github.io/helm-intro.html for this idea
    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
    (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; terminal <tab>
    (define-key helm-map (kbd "C-z") 'helm-select-action)

    ;; switch buffers/open recently opened files
    (global-set-key (kbd "C-x b") 'helm-mini)

    ;; search emacs functions and variables
    (global-set-key (kbd "C-h a") 'helm-apropos)

    ;;; evil keybindings to initiate helm
    (after 'evil
      (define-key evil-normal-state-map (kbd ";") 'helm-M-x)
      (define-key evil-visual-state-map (kbd ";") 'helm-M-x)
      (define-key evil-normal-state-map (kbd ", f") 'helm-find-files)
      (define-key evil-normal-state-map (kbd ", b") 'helm-mini)

      ;; search all the stuff you copied into emacs' kill-ring (clipboard)
      (define-key evil-normal-state-map (kbd ", e k") #'helm-show-kill-ring)

      ;; hop to function name
      (define-key evil-normal-state-map (kbd ", e f") #'helm-semantic-or-imenu)

      ;; helps to build (emacs lisp-style) regexps
      (define-key evil-normal-state-map (kbd ", e r") #'helm-regexp)

      ;; search man files (on *nix systems)
      (define-key evil-normal-state-map (kbd ", d m") #'helm-man-woman)

      ;; search the web: provide search string, then pick a search engine
      (define-key evil-normal-state-map (kbd ", d w") #'helm-surfraw)

      ;; search the list of colors that emacs knows of
      (define-key evil-normal-state-map (kbd ", d c") #'helm-colors))


    ;; download and search documentation (not useful on Windows)
    (use-package helm-dash
      :ensure t
      :config
      (progn
	(after 'evil
	  (define-key evil-normal-state-map (kbd ", d h") 'helm-dash))
	(setq helm-dash-common-docsets '("Emacs Lisp" "C" "JavaScript" "jQuery" "MySQL" "PHP"))))

    ;; quickly hop around file (deprecates ace-jump-mode)
    (use-package helm-swoop
      :ensure t
      :config
      (progn
	(after 'evil
	  (define-key evil-normal-state-map (kbd ", e s") 'helm-swoop))))

    ;; quickly hop around project
    (use-package helm-projectile
      :ensure t
      :config
      (progn
	(setq projectile-completion-system 'helm)
	(helm-projectile-on)
	(after 'evil
	  (after 'projectile
	    (define-key evil-normal-state-map (kbd "SPC") 'helm-projectile)
	    (define-key evil-normal-state-map (kbd ", p p") 'helm-projectile)
	    (define-key evil-normal-state-map (kbd ", p s") 'helm-projectile-switch-project)
	    (define-key evil-normal-state-map (kbd ", p a") 'helm-projectile-ag)))))

    ;; The rest of this is a giant chunk of code to get back ido-ish
    ;; file navigation in helm-find-files.  helm wants to execute the
    ;; persistent action (dired) while the "logical" thing to do for
    ;; anyone used to any other file finder is to recurse into that
    ;; directory with the file finder...  The default behavior makes
    ;; sense as it is "consistent" with the rest of Helm, but it
    ;; frustrates *me* and so I have no problem "fixing" it.

    ;; This code is working as of 2014-11-13.

    ;; The two following defuns are from https://github.com/emacs-helm/helm/issues/340
    (defun helm-ff-expand-dir (candidate)
      (let* ((follow (buffer-local-value
		      'helm-follow-mode
		      (get-buffer-create helm-buffer)))
	     (insert-in-minibuffer #'(lambda (fname)
				       (with-selected-window (minibuffer-window)
					 (unless follow
					   (delete-minibuffer-contents)
					   (set-text-properties 0 (length fname)
								nil fname)
					   (insert fname))))))
	(if (file-directory-p candidate)
	    (progn
	      (when (string= (helm-basename candidate) "..")
		(setq helm-ff-last-expanded helm-ff-default-directory))
	      (funcall insert-in-minibuffer (file-name-as-directory
					     (expand-file-name candidate))))
	  (helm-exit-minibuffer))))

    ;; Do the above directory expansion in helm as a persistent action
    (defun helm-ff-persistent-expand-dir ()
      (interactive)
      (helm-attrset 'expand-dir 'helm-ff-expand-dir)
      (helm-execute-persistent-action 'expand-dir))

    ;; And this one is from https://github.com/emacs-helm/helm/pull/327
    ;; (which links to a merge that was later deleted from core) that I
    ;; took and fixed a bit.
    (defun helm-ff-backspace (&rest args)
      "Call backspace or `helm-find-files-down-one-level'.
If sitting at the end of a file directory, backspace goes up one
level, like in `ido-find-file'. "
      (interactive "P")
      (let (backspace)
	(cond
	 ((looking-back "[/\\]")
	  (call-interactively 'helm-find-files-up-one-level))
	 (t
	  (setq backspace (lookup-key (current-global-map) (read-kbd-macro "DEL")))
	  (call-interactively backspace)))))

    (defun helm-ff-dired ()
      (interactive)
      (let ((input (file-name-directory (minibuffer-contents))))
      	(exit-recursive-edit)
      	(dired input)))

    (define-key helm-find-files-map (kbd "C-d") 'helm-ff-dired)
    (define-key helm-find-files-map (kbd "<backspace>") 'helm-ff-backspace)
    (define-key helm-find-files-map (kbd "RET") 'helm-ff-persistent-expand-dir)))

(provide 'init-helm)
