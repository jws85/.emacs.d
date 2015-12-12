(use-package yaml-mode
  :ensure t
  :config
  (progn
    (add-to-list 'auto-mode-alist (cons "\\.yml\\'" 'yaml-mode))
    (add-to-list 'auto-mode-alist (cons "\\.yaml\\'" 'yaml-mode))))

(use-package markdown-mode
  :ensure t
  :config
  (progn
    (add-to-list 'auto-mode-alist (cons "\\.md\\'" 'markdown-mode))))

(provide 'config/markup)
