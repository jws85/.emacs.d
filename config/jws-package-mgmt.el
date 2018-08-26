;; use-package, a.k.a. the best thing to ever happen to emacs
(require 'use-package)
(require 'package)

;; MELPA (forget Marmalade, it never worked for me)
(add-to-list 'package-archives
       '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; Enable packages
(package-initialize)

;; Refresh the package only if it hasn't already been done this session
(setq jws/package-refreshed-already nil)
(defun jws/package-refresh-once-a-session ()
  (if (eq jws/package-refreshed-already nil)
      (progn
        (package-refresh-contents)
        (setq jws/package-refreshed-already t))))

;; Only way to be sure...
(jws/package-refresh-once-a-session)

;; Refresh the package list, then install package if it hasn't already been installed
(defun jws/package-install (pkg)
  (unless (package-installed-p pkg)
    (jws/package-refresh-once-a-session)
    (package-install pkg)))

;; Hide packages from the modeline
(use-package diminish
  :ensure t)

;; Paradox is a slightly nicer package installation interface
(use-package paradox
  :ensure t
  :config
  (paradox-enable)

  (setq paradox-github-token t) ; disable GitHub integration

  (with-eval-after-load 'evil
    (add-to-list 'evil-emacs-state-modes 'paradox-menu-mode))
  (define-key paradox-menu-mode-map (kbd "j") 'next-line)
  (define-key paradox-menu-mode-map (kbd "k") 'previous-line))

(provide 'jws-package-mgmt)
