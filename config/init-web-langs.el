(require 'php-mode)

(add-hook 'php-mode-hook
	  (lambda () (c-set-style "linux")))

(setq php-template-compatibility nil)

(require 'multi-web-mode)

(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags '((php-mode "<\\?php\\|<\\?\\|<\\?=" "\\?>")
		  (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
		  (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "inc" "fnc" "ntk"))
(multi-web-global-mode 1)

(provide 'init-web-langs)
