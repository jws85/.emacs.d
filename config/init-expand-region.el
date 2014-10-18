(use-package expand-region
  :ensure t
  :config
  (progn
    (global-set-key (kbd "C-=") 'er/expand-region)))

(provide 'init-expand-region)
