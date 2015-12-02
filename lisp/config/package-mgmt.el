(use-package paradox
  :ensure t
  :config
  (progn
    ;; Need to decide whether to do regular Emacs or Evil for this mode
    (add-to-list 'evil-emacs-state-modes 'paradox-menu-mode)
    (define-key paradox-menu-mode-map (kbd "j") 'next-line)
    (define-key paradox-menu-mode-map (kbd "k") 'previous-line)))

(provide 'config/package-mgmt)
