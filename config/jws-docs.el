(require 'info)
(setq Info-directory-list
      (cons (expand-file-name (concat user-emacs-directory "info"))
            Info-default-directory-list))

(use-package zeal-at-point
  :ensure t
  :config
  (progn
    (global-set-key "\C-cd" 'zeal-at-point)))

(provide 'jws-docs)
