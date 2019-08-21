;; Switched from auto-complete because ac is not really being actively
;; developed anymore, and its nicer features could be kludgy (popup
;; window would sometimes mess up the fontification elsewhere on
;; screen).

;; I really liked auto-complete and am trying to make company work a lot
;; more like that package.

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet
  :config
  (yasnippet-snippets-initialize))

(use-package ivy-yasnippet
  :ensure t
  :after yasnippet
  :bind ("C-;" . ivy-yasnippet))

(use-package company
  :ensure t
  :defer t
  :init (company-mode)
  :config
  (progn
    (use-package company-web
      :ensure t
      :after web-mode
      :config
      (progn
        (require 'company-web-html)))

    (defun jws/company-abort-and-insert-newline ()
      "Meant for binding to RET in company-active-map"
      (interactive)
      (company-abort)
      (newline-and-indent))

    ;; with properly remapped keyboard, control is easier to hit than alt/meta
    (define-key company-active-map (kbd "C-n") #'company-select-next)
    (define-key company-active-map (kbd "C-p") #'company-select-previous)
    (define-key company-active-map (kbd "C-i") #'company-complete-common-or-cycle)
    (define-key company-active-map (kbd "C-j") #'company-complete-selection)

    ;; ret-to-complete is problematic at end of lines
    (define-key company-active-map (kbd "<return>") #'jws/company-abort-and-insert-newline)

    ;; abort if ESC
    (define-key company-active-map (kbd "ESC") #'company-abort)

    ;; For whatever reason, maybe because of the above ESC mapping, M-{1, 2... 0} do not work
    ;; in my install; it just complains about M-0, etc being equivalent to ESC.  Whatever,
    ;; I'll use Ctrl instead.
    (dotimes (i 9)
      (define-key company-active-map (read-kbd-macro (format "C-%d" i)) 'company-complete-number))

    (setq company-idle-delay 0.1
          company-minimum-prefix-length 2
          company-tooltip-limit 20
          company-selection-wrap-around t
          company-dabbrev-downcase nil
          company-dabbrev-ignore-case t
          company-show-numbers t)

    (add-hook 'after-init-hook 'global-company-mode)))

(provide 'jws-completion)
