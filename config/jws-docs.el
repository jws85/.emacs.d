(require 'info)
(setq Info-directory-list
      (cons (expand-file-name (concat user-emacs-directory "info"))
            Info-default-directory-list))

(provide 'jws-docs)
