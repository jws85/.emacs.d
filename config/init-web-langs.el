(require 'web-mode)

(use-package web-mode
  :mode (("\\.html?\\'" . web-mode)
	 ("\\.php\\'" . web-mode)))

(provide 'init-web-langs)
