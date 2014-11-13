;; Use Quicklisp to install swank in your preferred lisp and define
;; the lisp using slime-lisp-implementations

(use-package slime
  :ensure t)

(use-package paredit
  :ensure t
  :config
  (after 'evil
    (after 'diminish
      (diminish 'paredit-mode))

    (use-package evil-paredit
      :ensure t)

    (add-hook 'emacs-lisp-mode #'enable-paredit-mode)
    (add-hook 'lisp-mode-hook #'enable-paredit-mode)
    (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
    (add-hook 'scheme-mode-hook #'enable-paredit-mode)))

(provide 'init-lisp)
