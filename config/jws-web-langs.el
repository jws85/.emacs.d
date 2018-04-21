;; Color functions
;; From http://www.emacswiki.org/emacs/HexColour
(defun jws/hexcolor-luminance (color)
  "Calculate the luminance of a color string (e.g. \"#ffaa00\", \"blue\").
  This is 0.3 red + 0.59 green + 0.11 blue and always between 0 and 255."
  (let* ((values (x-color-values color))
	 (r (car values))
	 (g (cadr values))
	 (b (caddr values)))
    (floor (+ (* .3 r) (* .59 g) (* .11 b)) 256)))


(defun jws/hexcolor-add-to-font-lock ()
  (interactive)
  (font-lock-add-keywords nil
                  `((,(concat "#[0-9a-fA-F]\\{3\\}[0-9a-fA-F]\\{3\\}?\\|"
                              (regexp-opt (x-defined-colors) 'words))
                     (0 (let ((color (match-string-no-properties 0)))
                          (put-text-property
                           (match-beginning 0) (match-end 0)
                           'face `((:foreground ,(if (> 128.0 (jws/hexcolor-luminance color))
                                                     "white" "black"))
                                   (:background ,color)))))))))

;; Autocomplete
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

    ;; uh, why isn't this happening by default?
    (add-hook 'web-mode-hook (lambda () (run-hooks 'prog-mode-hook)))

    ;; still broken...
    (add-hook 'web-mode-hook
              (lambda ()
                (let ((cur-engine "php"))
                  (cond
                   ((string= cur-engine "php")
                    (jws/company-php-setup))))))
    ))

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
