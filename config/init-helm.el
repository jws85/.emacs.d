(use-package helm
  :ensure t
  :init (require 'helm-config)
  :config
  (progn
    (helm-mode 1)

    (setq helm-ff-file-name-history-use-recentf t
	  helm-buffers-fuzzy-matching t)

    (after 'diminish
      (diminish 'helm-mode))

    ;; keybindings used by helm itself
    ;; swaps C-z and <tab> -- this makes helm-find-files INFINITELY more usable
    ;; cheers to http://tuhdo.github.io/helm-intro.html for this idea
    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
    (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; terminal <tab>
    (define-key helm-map (kbd "C-z") 'helm-select-action)

    ;; keybindings to initiate helm
    (global-set-key (kbd "M-x") 'helm-M-x)
    (global-set-key (kbd "C-x C-f") 'helm-find-files)
    (global-set-key (kbd "C-x b") 'helm-mini)
    (global-set-key (kbd "C-h a") 'helm-apropos)
    (global-set-key (kbd "C-h i") 'helm-info-at-point)

    ;; evil keybindings to initiate helm
    (after 'evil
      (define-key evil-normal-state-map (kbd ";") 'helm-M-x)
      (define-key evil-visual-state-map (kbd ";") 'helm-M-x)
      (define-key evil-normal-state-map (kbd ", f") 'helm-find-files)
      (define-key evil-normal-state-map (kbd ", b") 'helm-mini))

    ;; download and search documentation
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
	  (define-key evil-normal-state-map (kbd "SPC") 'helm-swoop))))

    ;; quickly hop around project
    (use-package helm-projectile
      :ensure t
      :config
      (progn
	(setq projectile-completion-system 'helm)
	(helm-projectile-on)
	(after 'evil
	  (after 'projectile
	    (define-key evil-normal-state-map (kbd ", p p") 'helm-projectile)
	    (define-key evil-normal-state-map (kbd ", p s") 'helm-projectile-switch-project)
	    (define-key evil-normal-state-map (kbd ", p a") 'helm-projectile-ag)))))

    ;; The rest of this is a giant chunk of code to get back ido-ish
    ;; file navigation in helm-find-files.  helm wants to execute the
    ;; persistent action (dired) while the "logical" thing to do for
    ;; anyone used to any other file finder is to recurse into that
    ;; directory with the file finder...

    ;; The code is from https://github.com/emacs-helm/helm/issues/340
    ;; and is working as of 2014-11-13.

    ;; Expand the directory
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

    (define-key helm-find-files-map (kbd "RET") 'helm-ff-persistent-expand-dir)))

(provide 'init-helm)
