;;;; custom.el
;; Time-stamp: <2014-07-08 21:19:54 jws>
;;
;; 2013-11-05:  Note lazy-highlight and isearch-lazy-highlight-face
;;              These are set in my jellybeans-theme but also here because
;;              these faces are DUMBARSE FUTHERMUCKERS and do not want
;;              to inherit their value like all sane faces.  So my nice
;;              highlights are assaulted by hideous blue color that looks
;;              like a UNC fratboy puked on a Duke fratboy unless I do
;;              this.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   (quote
    ((js-indent-level . 8)
     (css-indent-offset . 8)
     (sgml-basic-offset . 8)
     (eval add-hook
	   (quote php-mode-hook)
	   (lambda nil
	     (c-default-style "linux")
	     (c-basic-offset 8)))
     (c-default-style . "linux")
     (eval define-key php-mode-map
	   (kbd "TAB")
	   (quote self-insert-command))
     (eval define-key web-mode-map
	   (kbd "TAB")
	   (quote self-insert-command))
     (web-mode-disable-auto-pairing . t)
     (web-mode-code-indent-offset . 8)
     (web-mode-css-indent-offset . 8)
     (web-mode-markup-indent-offset . 8)
     (evil-shift-width . 8)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
