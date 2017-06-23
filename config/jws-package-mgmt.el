(use-package paradox
  :ensure t
  :init (require 'paradox)
  :config
  (progn
    (paradox-enable)

    (add-to-list 'evil-emacs-state-modes 'paradox-menu-mode)
    (define-key paradox-menu-mode-map (kbd "j") 'next-line)
    (define-key paradox-menu-mode-map (kbd "k") 'previous-line)))

(provide 'jws-package-mgmt)
