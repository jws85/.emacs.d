;; Enable winner-mode
(winner-mode 1)

(use-package popwin
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (after 'diminish
    (diminish 'which-key-mode))

  (which-key-mode)
  (setq which-key-idle-delay 0.1))

(provide 'jws-window)
