;; Disable company-mode in shell, to prevent needing to hit RET twice
(defun jws/disable-completion-in-shell ()
  (company-mode -1)
  (setq-local company-mode nil))
(add-hook 'shell-mode-hook #'jws/disable-completion-in-shell)

;; Open up shell through shortcut
(global-set-key (kbd "M-j s") 'shell)
(after 'evil (define-key evil-normal-state-map (kbd "SPC s") 'shell))

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
