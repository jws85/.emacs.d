(use-package auto-complete
  :ensure t
  :init
  (progn
    (require 'auto-complete-config)
    (ac-config-default))
  :config
  (progn
    (diminish 'auto-complete-mode)

    (setq ac-comphist-file (concat user-emacs-directory ".cache/ac-comphist.dat"))
    (setq ac-delay 0.05) ; completion list delay
    (setq ac-auto-show-menu t)
    (setq ac-quick-help-delay 0.3) ; tooltip delay
    (setq ac-quick-help-height 30)
    (setq ac-show-menu-immediately-on-auto-complete t)

    (after 'linum (ac-linum-workaround))))

(provide 'init-auto-complete)
