(use-package magit
  :ensure t
  :config
  (progn
    (after 'diminish
      (diminish 'magit-auto-revert-mode))))

(provide 'init-git)
