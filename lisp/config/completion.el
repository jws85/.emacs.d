;; Switched from auto-complete because ac is not really being actively
;; developed anymore, and its nicer features could be kludgy (popup
;; window would sometimes mess up the fontification elsewhere on
;; screen).

;; I really liked auto-complete and am trying to make company work a lot
;; more like that package.

(use-package company
  :ensure t
  :init (company-mode)
  :config
  (progn
    (after 'diminish
      (diminish 'company-mode))

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
    ;; this code is largely taken from https://github.com/tungd/dotfiles emacs setup
    ;; and is intended to replicate how I recall auto-complete working because I
    ;; liked that a lot better...
    (defun company-complete-dwim (&optional arg)
      (interactive "P")
      (let ((pos (point)))
        (when (and (= pos (point)) (looking-at "\\_>"))
          (if (eq last-command 'company-complete-dwim)
              (company-select-next)
            (company-complete-selection)))))
    (define-key company-active-map (kbd "C-i") #'company-complete-dwim)
    (define-key company-active-map (kbd "<tab>") #'company-complete-dwim)
    (define-key company-active-map (kbd "<backtab>") #'company-select-previous)
    (define-key company-active-map (kbd "C-j") #'company-complete)

    ;; ret-to-complete is problematic at end of lines
    (define-key company-active-map (kbd "<return>") #'jws/company-abort-and-insert-newline)

    ;; abort if ESC
    (define-key company-active-map (kbd "ESC") #'company-abort)

    (setq company-idle-delay 0.1
	  company-minimum-prefix-length 2
	  company-tooltip-limit 20
	  company-selection-wrap-around t
	  company-dabbrev-downcase nil
	  company-dabbrev-ignore-case t)

    (add-hook 'after-init-hook 'global-company-mode)))

(provide 'config/completion)
