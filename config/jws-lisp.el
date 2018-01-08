;; Use Quicklisp to install swank in your preferred lisp and define
;; the lisp using slime-lisp-implementations

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
  (define-key lispy-mode-map-lispy (kbd "\"") nil))

;; syntax highlight Cask files
(use-package cask-mode :ensure t)

(use-package nameless
  :ensure t
  :config
  (progn
    (add-hook 'emacs-lisp-mode-hook #'nameless-mode)))

;; ;; I am trying to do the following: If there is a Cask file somewhere in the
;; ;; upwards file hierarchy for this elisp file, enable flycheck-package,
;; ;; otherwise do not.
;; (use-package flycheck-cask :ensure t)
;; (use-package flycheck-package :after flycheck-cask :ensure t)
;; (jws/after (flycheck-package)
;;     (add-hook 'flycheck-mode-hook #'flycheck-cask-setup)
;;     (add-hook 'flycheck-mode-hook #'flycheck-package-setup)
;;     (add-hook 'emacs-lisp-mode-hook #'flycheck-mode))

(provide 'jws-lisp)
