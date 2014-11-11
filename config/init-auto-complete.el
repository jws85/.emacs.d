;; originally named auto-complete because I used auto-complete mode;
;; but now I use company

(use-package company
  :ensure t
  :init (company-mode)
  :config
  (progn
    (define-key company-active-map (kbd "M-n") nil)
    (define-key company-active-map (kbd "M-p") nil)
    (define-key company-active-map (kbd "C-n") #'company-select-next-or-abort)
    (define-key company-active-map (kbd "C-p") #'company-select-previous-or-abort)

    (setq company-idle-delay 0.1
	  company-minimum-prefix-length 1
	  company-tooltip-limit 20
	  company-selection-wrap-around t)

    (add-hook 'after-init-hook 'global-company-mode)))

(provide 'init-auto-complete)
