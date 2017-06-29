; Autocomplete
(use-package company-php
  :ensure t
  :config
  (progn
    (defun jws/company-php-setup ()
      (require 'company-php)
      (company-mode t)
      (ac-php-core-eldoc-setup)
      (after 'diminish
        (diminish 'eldoc-mode))
      (make-local-variable 'company-backends)
      (add-to-list 'company-backends 'company-ac-php-backend))))

(defun jws/php-definition-of-word ()
  (modify-syntax-entry ?_ "w"))

(use-package web-mode
  :ensure t
  :mode (("\\.html?\\'" . web-mode)
	 ("\\.php\\'" . web-mode)
	 ("\\.phtml\\'" . web-mode)
	 ("\\.tpl\\.php\\'" . web-mode)
	 ("\\.[agj]sp\\'" . web-mode)
	 ("\\.as[cp]x\\'" . web-mode)
	 ("\\.erb\\'" . web-mode)
	 ("\\.mustache\\'" . web-mode)
	 ("\\.djhtml\\'" . web-mode))
  :init (require 'web-mode)
  :config
  (progn
    (setq web-mode-enable-auto-pairing nil
          web-mode-enable-auto-quoting nil)

    ;; still broken...
    (add-hook 'web-mode-hook
              (lambda ()
                (let ((cur-engine "php"))
                  (cond
                   ((string= cur-engine "php")
                    (jws/company-php-setup))))))
    ))

(require 'jws-hexcolor)
(add-hook 'css-mode-hook 'jws/hexcolor-add-to-font-lock)

(use-package coffee-mode
  :ensure t
  :mode (("\\.coffee\\'" . coffee-mode))
  :config
  (progn
    (setq coffee-tab-width 4)))

(use-package scss-mode
  :ensure t
  :mode (("\\.scss\\'" . scss-mode)))

(use-package php-mode
  :ensure t
  :config
  (progn
    (setq c-basic-offset 4)
    (add-hook 'php-mode-hook #'jws/php-definition-of-word)
    (add-hook 'php-mode-hook #'jws/company-php-setup)))

(provide 'jws-web-langs)
