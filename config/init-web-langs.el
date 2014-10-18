(require 'web-mode)

(use-package web-mode
  :mode (("\\.html?\\'" . web-mode)
	 ("\\.php\\'" . web-mode))
  :config
  (progn
    (add-to-list 'ac-modes 'web-mode)

    (setq web-mode-ac-sources-alist
	  '(("css" . (ac-source-words-in-buffer ac-source-css-property))
	    ("html" . (ac-source-words-in-buffer ac-source-abbrev))
	    ("php" . (ac-source-words-in-buffer
		      ac-source-words-in-same-mode-buffers
		      ac-source-dictionary))))))

(add-hook 'css-mode-hook 'jws/hexcolor-add-to-font-lock)

(provide 'init-web-langs)
