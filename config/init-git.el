(use-package magit
  :ensure t
  :config
  (progn
    (after 'evil
      (define-key evil-normal-state-map (kbd ", g") 'magit-status))
    (after 'diminish
      (diminish 'magit-auto-revert-mode))))

(provide 'init-git)
