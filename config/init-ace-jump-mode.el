(use-package ace-jump-mode
  :ensure t
  :config
  (after 'evil
    (define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)))

(provide 'init-ace-jump-mode)
