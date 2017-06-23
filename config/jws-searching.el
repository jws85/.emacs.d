;; Lossage in switch to ivy:
;;  ,eo -- #'helm-occur, which is basically swiper
;;  ,ef -- #'helm-semantic-or-imenu
;;  ,er -- #'helm-regexp
;;  ,ew -- #'helm-surfraw

(use-package ivy
  :ensure t
  :init
  (progn
    (require 'ivy)
    (ivy-mode 1))
  :config
  (progn
    (after 'diminish
      (diminish 'ivy-mode))

    (use-package ivy-hydra :ensure t :init (require 'ivy-hydra))
    (use-package counsel :ensure t :init (require 'counsel))
    (use-package swiper :ensure t :init (require 'swiper))
    (use-package flx :ensure t :init (require 'flx))
    (use-package smex :ensure t :init (require 'smex))

    (after 'projectile
      (use-package counsel-projectile :ensure t
        :init (require 'counsel-projectile)
        :config (counsel-projectile-on)))

    (setq ivy-use-virtual-buffers t
          ivy-count-format "(%d/%d)"
          ivy-magic-tilde nil
          counsel-find-file-at-point t)

    ;; I'm not sure of the implication of this... but it fixes an irritating
    ;; impedance mismatch between helm/ivy and ido.  When you use RET in
    ;; ido-find-files on a dir, it does ido on the dir.  When you use RET in
    ;; ivy/helm, it fires up dired, killing my flow like nothing else.
    ;; This fixes that!
    (define-key ivy-minibuffer-map (kbd "<return>") 'ivy-alt-done)

    (global-set-key (kbd "C-s") 'counsel-grep-or-swiper)

    ;; counsel-surfraw begins here
    ;; This is some code I wrote to reimplement helm-surfraw in counsel/ivy.
    ;; Should probably separate it into a separate project.
    (defun jws/counsel-surfraw ()
      "Search for something online, using the surfraw command."
      (interactive)
      (let ((search-for (read-string "Search for: " nil 'counsel-surfraw-search-history
                                     (thing-at-point 'symbol))))
        (ivy-read (format "Search for `%s` with: " search-for)
                  #'jws/counsel-surfraw-elvi
                  :require-match t
                  :history 'counsel-surfraw-engine-history
                  :sort t
                  :action
                  (lambda (selected-elvis)
                    (browse-url (shell-command-to-string
                                 (format "sr %s -p %s"
                                         (get-text-property 0 'elvis selected-elvis)
                                         search-for)))))))

    (defun jws/counsel-surfraw-elvi (str pred _)
      "Return a list of surfraw elvi (search engines).

I don't know what the parameters are, they are for compatibility with 'all-completions'.
Just listing them here to keep flycheck happy:  STR PRED _"
      (mapcar
       'jws/counsel-surfraw-elvis
       (seq-remove
        (lambda (str) (not (string-match-p "--" str)))
        (split-string (shell-command-to-string "surfraw -elvi") "\n"))))

    (defun jws/counsel-surfraw-elvis (elvis)
      "Process an individual surfraw ELVIS."
      (let* ((list (split-string elvis "--"))
             (key (string-trim (nth 0 list)))
             (value (string-trim (nth 1 list)))
             (text (format "%-20s %s" key value)))
        (propertize text 'elvis key)))
    ;; counsel-surfraw ends here

    (after 'projectile
      (setq projectile-completion-system 'ivy))

    (after 'magit
      (setq magit-completing-read-function 'ivy-completing-read))

    (after 'evil
      (after 'projectile
        (define-key evil-normal-state-map (kbd ", p g") 'counsel-projectile-ag)
        ;; If projectile is active in a buffer, use the projectile project as the
        ;; ag bounds; otherwise just ag in the file's directory
        (defun jws/counsel-ag-contextual ()
          (interactive)
          (if (projectile-project-p)
              (counsel-projectile-ag)
            (counsel-ag)))
        (define-key evil-normal-state-map (kbd ", e g") 'jws/counsel-ag-contextual))

      (define-key evil-normal-state-map (kbd "/") 'counsel-grep-or-swiper)
      (define-key evil-normal-state-map (kbd ";") 'counsel-M-x)
      (define-key evil-visual-state-map (kbd ";") 'counsel-M-x)
      (define-key evil-normal-state-map (kbd ", f") 'counsel-find-file)
      (define-key evil-normal-state-map (kbd ", b") 'ivy-switch-buffer)
      (define-key evil-normal-state-map (kbd ", e u") 'counsel-unicode-char)
      (define-key evil-normal-state-map (kbd ", e l") 'counsel-locate)
      (define-key evil-normal-state-map (kbd ", e c") 'counsel-colors-web)
      (define-key evil-normal-state-map (kbd ", e k") 'counsel-yank-pop)
      (define-key evil-normal-state-map (kbd ", e m") 'woman)
      (define-key evil-normal-state-map (kbd ", e w") 'jws/counsel-surfraw))))

(provide 'jws-searching)
