(require 'info)
(setq Info-directory-list
      (cons (expand-file-name (concat user-emacs-directory "info"))
            Info-default-directory-list))

(use-package zeal-at-point
  :ensure t
  :config
  (progn
    (define-key evil-normal-state-map (kbd ", h z") 'zeal-at-point)
    (global-set-key "\C-hz" 'zeal-at-point)))

(provide 'jws-docs)
