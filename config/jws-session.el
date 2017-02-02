;; Session management

(setq desktop-dirname             "~/.emacs.d/.cache/desktop/"
      desktop-base-file-name      "emacs.desktop"
      desktop-base-lock-name      "lock"
      desktop-path                (list desktop-dirname)
      desktop-save                t
      desktop-files-not-to-save   "^$" ;reload tramp paths
      desktop-load-locked-desktop nil)

;; Always save the session
(desktop-save-mode 1)

(provide 'jws-session)
