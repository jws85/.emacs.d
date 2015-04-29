(use-package markdown-mode
  :ensure t
  :config
  (progn
    (add-to-list 'auto-mode-alist (cons "\\.md\\'" 'markdown-mode))))

(provide 'config/markdown)
