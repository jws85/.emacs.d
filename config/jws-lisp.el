;; Use Quicklisp to install swank in your preferred lisp and define
;; the lisp using slime-lisp-implementations

(defun jws/lisp-definition-of-word ()
  (modify-syntax-entry ?- "w"))

(add-hook 'lisp-mode-hook #'jws/lisp-definition-of-word)
(add-hook 'emacs-lisp-mode-hook #'jws/lisp-definition-of-word)

(use-package slime
  :ensure t
  :config
  (progn
    (slime-setup '(slime-fancy))))

(use-package lispy
  :ensure t)

(use-package lispyville
  :ensure t
  :after (evil lispy)
  :config
  (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
  (add-hook 'lispy-mode-hook #'lispyville-mode)
  (after 'diminish
    (diminish 'lispyville-mode)
    (diminish 'lispy-mode))
  (define-key lispy-mode-map-lispy (kbd "\"") nil))

(after 'diminish
  (diminish 'eldoc-mode))

(provide 'jws-lisp)
