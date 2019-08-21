;; Even easier than diminish -- just hide all minor modes
(use-package minions
  :ensure t
  :config
  (minions-mode 1))

;; Nyan~ ^_^
(use-package nyan-mode
  :ensure t
  :config
  (nyan-mode)
  (setq nyan-bar-length 20))

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  (column-number-mode)
  (setq doom-modeline-buffer-file-name-style 'buffer-name))

(provide 'jws-modeline)
