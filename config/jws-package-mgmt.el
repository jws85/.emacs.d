;; a.k.a. the best thing to ever happen to emacs
(require 'use-package)
(require 'package)

;; MELPA (forget Marmalade, it never worked for me)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; Enable packages
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; Paradox is a slightly nicer package installation interface
(use-package paradox
  :ensure t
  :config
  (progn
    (paradox-enable)

    (with-eval-after-load 'evil
      (add-to-list 'evil-emacs-state-modes 'paradox-menu-mode))
    (define-key paradox-menu-mode-map (kbd "j") 'next-line)
    (define-key paradox-menu-mode-map (kbd "k") 'previous-line)))

(provide 'jws-package-mgmt)
