;; Enable winner-mode
(winner-mode 1)

(use-package popwin
  :ensure t
  :config
  (popwin-mode))

(use-package which-key
  :ensure t
  :config
  (after 'diminish
    (diminish 'which-key-mode))

  (which-key-mode)
  (after 'diminish
    (diminish 'which-key-mode))
  (setq which-key-idle-delay 0.1))

(provide 'jws-window)
