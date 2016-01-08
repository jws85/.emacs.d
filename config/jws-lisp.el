;; Use Quicklisp to install swank in your preferred lisp and define
;; the lisp using slime-lisp-implementations

(defun jws/lisp-hook ()
  (modify-syntax-entry ?- "w"))
(add-hook 'lisp-mode-hook #'jws/lisp-hook)
(add-hook 'emacs-lisp-mode-hook #'jws/lisp-hook)

(use-package slime
  :ensure t)

(provide 'jws-lisp)
