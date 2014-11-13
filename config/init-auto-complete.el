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
    (defun jws/company-abort-and-insert-newline ()
      "Meant for binding to RET in company-active-map"
      (interactive)
      (company-abort)
      (newline-and-indent))

    ;; with properly remapped keyboard, control is easier to hit than alt/meta
    (define-key company-active-map (kbd "M-n") nil)
    (define-key company-active-map (kbd "M-p") nil)
    (define-key company-active-map (kbd "C-n") #'company-select-next)
    (define-key company-active-map (kbd "C-p") #'company-select-previous)

    ;; complete with tab (C-i is the equivalent of tab in terminals)
    (define-key company-active-map (kbd "C-i") #'company-complete-selection)
    (define-key company-active-map (kbd "<tab>") #'company-complete-selection)
    
    ;; ret-to-complete is problematic at end of lines
    (define-key company-active-map (kbd "<return>") #'jws/company-abort-and-insert-newline)

    ;; abort if ESC
    (define-key company-active-map (kbd "ESC") #'company-abort)

    (setq company-idle-delay 0.1
	  company-minimum-prefix-length 1
	  company-tooltip-limit 20
	  company-selection-wrap-around t)

    (add-hook 'after-init-hook 'global-company-mode)))

(provide 'init-auto-complete)
