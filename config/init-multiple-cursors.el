(require 'multiple-cursors)
(after 'evil
  (add-hook 'multiple-cursors-mode-enabled-hook 'evil-emacs-state)
  (add-hook 'multiple-cursors-mode-disabled-hook 'evil-normal-state))

(setq mc/list-file (concat user-emacs-directory ".cache/.mc-lists.el"))

(after 'multiple-cursors
;  (define-key evil-emacs-state-map (kbd "C->") 'mc/mark-next-like-this)
;  (define-key evil-emacs-state-map (kbd "C-<") 'mc/mark-previous-like-this)
;  (define-key evil-visual-state-map (kbd "C->") 'mc/mark-all-like-this)
;  (define-key evil-normal-state-map (kbd "C->") 'mc/mark-next-like-this)
;  (define-key evil-normal-state-map (kbd "C-<") 'mc/mark-previous-like-this)
  (define-key evil-visual-state-map (kbd "C->") 'mc/mark-next-like-this)
  (define-key evil-visual-state-map (kbd "C-<") 'mc/mark-previous-like-this))

(provide 'init-multiple-cursors)
