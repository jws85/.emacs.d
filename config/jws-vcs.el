(use-package magit
  :ensure t
  :config
  (setq magit-last-seen-setup-instructions "1.4.0")

  (after 'diminish
    (diminish 'auto-revert-mode))

  (define-key jws/leader-map (kbd "g") 'magit-status))

(use-package magit-gitflow
  :ensure t
  :after magit
  :config
  (require 'magit-gitflow)
  (add-hook 'magit-mode-hook 'turn-on-magit-gitflow)
  (define-key magit-mode-map "%" 'magit-gitflow-popup))

(use-package evil-magit
  :ensure t
  :after (evil magit)
  :config
  (require 'evil-magit)
  (define-key magit-mode-map (kbd "C-f") nil))

(provide 'jws-vcs)
