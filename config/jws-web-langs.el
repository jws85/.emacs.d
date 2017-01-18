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
          web-mode-enable-auto-quoting nil)))

(require 'jws-hexcolor)
(add-hook 'css-mode-hook 'jws/hexcolor-add-to-font-lock)

(provide 'jws-web-langs)

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
    (setq c-basic-offset 4)))
