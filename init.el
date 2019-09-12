;; You *MUST* have this here or Emacs throws a tantrum and puts
;; it there for you anyways.
(package-initialize)

;; Untangle my config from its org-mode file and load it
(org-babel-load-file (concat user-emacs-directory "config.org"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ivy-rich nyan-mode minions doom-modeline use-package smex paradox focus flx evil-surround evil-collection doom-themes counsel))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
