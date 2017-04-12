;; Session management

;; Create directory
(if (not (file-exists-p jws/emacs-desktop-dir))
    (make-directory jws/emacs-desktop-dir t))

(setq desktop-dirname             jws/emacs-desktop-dir
      desktop-base-file-name      "emacs.desktop"
      desktop-base-lock-name      "lock"
      desktop-path                (list desktop-dirname)
      desktop-save                t
      desktop-files-not-to-save   "^$" ;reload tramp paths
      desktop-load-locked-desktop nil)

;; Always save the session
(desktop-save-mode 1)

(provide 'jws-session)
