(require 'info)
(setq Info-directory-list
      (cons (expand-file-name (concat user-emacs-directory "info"))
            Info-default-directory-list))

(define-key jws/leader-map (kbd "h i") 'info)
(define-key jws/leader-map (kbd "h f") 'describe-function)
(define-key jws/leader-map (kbd "h v") 'describe-variable)

;; [FIXME] should look into a counsel version of helm-man-woman
;; woman is an elisp reimplementation of the Unix man(1) command, e.g. for
;; windows; this is handy there, but everywhere else, man(1) will be a
;; heckuva lot faster.
(define-key jws/leader-map (kbd "h m") 'woman)

(use-package zeal-at-point
  :ensure t
  :config
  (define-key jws/leader-map (kbd "h d") 'zeal-at-point))

(provide 'jws-docs)
