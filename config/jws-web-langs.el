(use-package web-mode
  :ensure t
  :mode (("\\.html?\\'" . web-mode)
	 ("\\.php\\'" . web-mode))
  :init (require 'web-mode)
  :config
  (progn
    (setq web-mode-enable-auto-pairing nil
          web-mode-enable-auto-quoting nil)))

(require 'jws-hexcolor)
(add-hook 'css-mode-hook 'jws/hexcolor-add-to-font-lock)

(provide 'jws-web-langs)
