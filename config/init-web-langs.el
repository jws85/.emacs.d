(use-package web-mode
  :ensure t
  :mode (("\\.html?\\'" . web-mode)
	 ("\\.php\\'" . web-mode))
  :init (require 'web-mode))

(add-hook 'css-mode-hook 'jws/hexcolor-add-to-font-lock)

(provide 'init-web-langs)
