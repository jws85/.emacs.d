(use-package helm
  :ensure t
  :init (require 'helm-config)
  :config
  (progn
    (helm-mode 1)

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

    (use-package helm-dash
      :ensure t
      :config
      (progn
	(after 'evil
	  (define-key evil-normal-state-map (kbd ", d h") 'helm-dash))
	(setq helm-dash-common-docsets '("Emacs Lisp" "C" "JavaScript" "jQuery" "MySQL" "PHP"))))

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
    ))

(provide 'init-helm)
