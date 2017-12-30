(use-package magit
  :ensure t
  :config
  (setq magit-last-seen-setup-instructions "1.4.0")

  (after 'diminish
    (diminish 'auto-revert-mode))

  (global-set-key (kbd "M-j g") 'magit-status)

  (after 'evil
    (use-package evil-magit
      :ensure t
      :config
      (require 'evil-magit))

    (define-key evil-normal-state-map (kbd "SPC g") 'magit-status)))

(provide 'jws-vcs)
