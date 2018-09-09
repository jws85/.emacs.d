;; Parinfer is a FRIGGIN' REVELATION HOLY CARP WHERE HAS THIS BEEN
;; MY WHOLE LIFE OMG OMG OMG
;;
;;   https://shaunlebron.github.io/parinfer/
;;   https://github.com/DogLooksGood/parinfer-mode
(use-package parinfer
  :ensure t
  :bind ("C-," . parinfer-toggle-mode)
  :init
  (progn
    (setq parinfer-extensions
          '(defaults pretty-parens evil smart-tab smart-yank))
    (add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
    (add-hook 'common-lisp-mode-hook #'parinfer-mode)
    (add-hook 'scheme-mode-hook #'parinfer-mode)
    (add-hook 'lisp-mode-hook #'parinfer-mode)
    (add-hook 'lisp-interaction-mode-hook #'parinfer-mode)))

;; Common Lisp ---------------------------------------------------------------
;; It is actually much easier to install SLIME via Quicklisp:
;;    https://www.quicklisp.org/beta/
;;
;; Once you have QL loaded, run
;;    (ql:quickload "quicklisp-slime-helper")
;; and copy the lines given to you into site-init.el

;; Emacs Lisp ----------------------------------------------------------------

;; syntax highlight Cask files
(use-package cask-mode :ensure t)

(use-package nameless
  :ensure t
  :config
  (after 'diminish
    (diminish 'nameless-mode))
  (add-hook 'emacs-lisp-mode-hook #'nameless-mode))

;; ;; I am trying to do the following: If there is a Cask file somewhere in the
;; ;; upwards file hierarchy for this elisp file, enable flycheck-package,
;; ;; otherwise do not.
;; (use-package flycheck-cask :ensure t)
;; (use-package flycheck-package :after flycheck-cask :ensure t)
;; (jws/after (flycheck-package)
;;     (add-hook 'flycheck-mode-hook #'flycheck-cask-setup)
;;     (add-hook 'flycheck-mode-hook #'flycheck-package-setup)
;;     (add-hook 'emacs-lisp-mode-hook #'flycheck-mode))

(after 'diminish
  (diminish 'eldoc-mode))

(provide 'jws-lisp)
