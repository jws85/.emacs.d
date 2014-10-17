(require 'web-mode)

(use-package web-mode
  :mode (("\\.html?\\'" . web-mode)
	 ("\\.php\\'" . web-mode)))

(add-hook 'css-mode-hook 'jws/hexcolor-add-to-font-lock)

(provide 'init-web-langs)
