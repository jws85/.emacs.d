;; Use Quicklisp to install swank in your preferred lisp and define
;; the lisp using slime-lisp-implementations

(use-package slime
  :ensure t)

(use-package paredit
  :ensure t
  :config
  (after 'evil
    (after 'diminish
      (diminish 'paredit-mode))

    (use-package evil-paredit
      :ensure t
      :config
      (progn
	;; otherwise the ordinary evil delete will happily eat your parens
	(add-hook 'evil-paredit-mode-hook
		  (lambda ()
		    (define-key evil-insert-state-map (kbd "<backspace>") #'paredit-backward-delete)))

	(defun jws/paredit-hook ()
	  (enable-paredit-mode)
	  (evil-paredit-mode))

	(add-hook 'emacs-lisp-mode-hook #'jws/paredit-hook)
	(add-hook 'lisp-mode-hook #'jws/paredit-hook)
	(add-hook 'lisp-interaction-mode-hook #'jws/paredit-hook)
	(add-hook 'scheme-mode-hook #'jws/paredit-hook)))))

(provide 'init-lisp)
