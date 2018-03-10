(require 'info)
(setq Info-directory-list
      (cons (expand-file-name (concat user-emacs-directory "info"))
            Info-default-directory-list))

(global-set-key (kbd "M-j h i") 'info)
(define-key evil-normal-state-map (kbd "SPC h i") 'info)

(global-set-key (kbd "M-j h f") 'describe-function)
(define-key evil-normal-state-map (kbd "SPC h f") 'describe-function)

(global-set-key (kbd "M-j h v") 'describe-variable)
(define-key evil-normal-state-map (kbd "SPC h v") 'describe-variable)

;; [FIXME] would like to replace with counsel version of same... that doesn't exist...
(global-set-key (kbd "M-j h m") 'helm-man-woman)
(define-key evil-normal-state-map (kbd "SPC h m") 'helm-man-woman)

(use-package zeal-at-point
  :ensure t
  :config
  (progn
    (global-set-key (kbd "M-j h d") 'zeal-at-point)
    (define-key evil-normal-state-map (kbd "SPC h d") 'zeal-at-point)))

(provide 'jws-docs)
