(require 'package)

;; MELPA (forget Marmalade, it never worked for me)
(add-to-list 'package-archives
       '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; Enable packages
(package-initialize)

(defun jws/is-refresh-needed (refresh-interval)
  "Determine whether a package refresh is needed -- every REFRESH-INTERVAL days"
  (let* ((now (float-time (current-time)))
         (package-archive-file "~/.emacs.d/elpa/archives/melpa/archive-contents")
         (then (float-time (nth 5 (file-attributes package-archive-file))))
         (refresh-interval-secs (* 24 60 60 refresh-interval)))
    (> (- now then)
       refresh-interval-secs)))

(defun jws/package-refresh-once-a-session ()
  "Refresh package list once a session, if needed"
  (if (eq jws/package-refreshed-already nil)
      (progn
        (package-refresh-contents)
        (setq jws/package-refreshed-already t))))

;; Only refresh packages once every seven days
(setq jws/package-refreshed-already (jws/is-refresh-needed 7))
(jws/package-refresh-once-a-session)

;; Refresh the package list, then install package if it hasn't already been installed
(defun jws/package-install (pkg)
  (unless (package-installed-p pkg)
    (jws/package-refresh-once-a-session)
    (package-install pkg)))

;; use-package, a.k.a. the best thing to ever happen to emacs
(jws/package-install 'use-package)
(eval-when-compile
  (require 'use-package))

;; Paradox is a slightly nicer package installation interface
(use-package paradox
  :ensure t
  :commands (paradox-list-packages paradox-upgrade-packages)
  :config
  (setq paradox-github-token t) ; disable GitHub integration
  (with-eval-after-load 'evil
    (add-to-list 'evil-emacs-state-modes 'paradox-menu-mode))
  (define-key paradox-menu-mode-map (kbd "j") 'next-line)
  (define-key paradox-menu-mode-map (kbd "k") 'previous-line))

(provide 'jws-package-mgmt)
