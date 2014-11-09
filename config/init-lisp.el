;; Use Quicklisp to install swank in your preferred lisp and define
;; the lisp using slime-lisp-implementations

(use-package slime
  :ensure t)

(use-package paredit
  :ensure t
  :config
  (after 'evil
    (use-package evil-paredit
      :ensure t)))

(provide 'init-lisp)
