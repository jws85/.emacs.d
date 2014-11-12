;; originally named auto-complete because I used auto-complete mode;
;; but now I use company because allegedly it's better maintained and
;; it does have better support for some things I use

;; I really liked auto-complete and am trying to make this work a lot
;; more like that package.

(use-package company
  :ensure t
  :init (company-mode)
  :config
  (progn
    ;; with remapped keyboard, control is easier to hit than alt/meta
    (define-key company-active-map (kbd "M-n") nil)
    (define-key company-active-map (kbd "M-p") nil)
    (define-key company-active-map (kbd "C-n") #'company-select-next-or-abort)
    (define-key company-active-map (kbd "C-p") #'company-select-previous-or-abort)

    ;; ret-to-complete is problematic at end of lines
    (define-key company-active-map (kbd "<return>") nil)
    (define-key company-active-map (kbd "C-i") #'company-complete-selection)
    (define-key company-active-map (kbd "<tab>") #'company-complete-selection)

    ;; abort if ESC
    (define-key company-active-map (kbd "ESC") #'company-abort)

    (setq company-idle-delay 0.1
	  company-minimum-prefix-length 1
	  company-tooltip-limit 20
	  company-selection-wrap-around t)

    (add-hook 'after-init-hook 'global-company-mode)))

(provide 'init-auto-complete)
