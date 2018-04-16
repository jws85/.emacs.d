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

;; [FIXME] should look into a counsel version of helm-man-woman
;; woman is an elisp reimplementation of the Unix man(1) command, e.g. for
;; windows; this is handy there, but everywhere else, man(1) will be a
;; heckuva lot faster.
(global-set-key (kbd "M-j h m") 'woman)
(define-key evil-normal-state-map (kbd "SPC h m") 'woman)

(use-package zeal-at-point
  :ensure t
  :config
  (progn
    (global-set-key (kbd "M-j h d") 'zeal-at-point)
    (define-key evil-normal-state-map (kbd "SPC h d") 'zeal-at-point)))

(provide 'jws-docs)
