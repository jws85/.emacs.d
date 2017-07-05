;; Turn off evil-mode when viewing images
(require 'image-mode)
(evil-set-initial-state 'image-mode 'emacs)

;; make-it-so, a package to perform batch file conversions with dired
(use-package make-it-so
  :ensure t
  :init (require 'make-it-so)
  :config
  (progn
    (setq mis-recipes-directory (expand-file-name (concat user-emacs-directory "etc/make-it-so")))
    (define-key dired-mode-map (kbd ", ,") 'make-it-so)))

(provide 'jws-utils)
