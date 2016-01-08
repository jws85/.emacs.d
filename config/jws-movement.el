;; Select increasingly large areas of text with C-=
(use-package expand-region
  :ensure t
  :config
  (progn
    (global-set-key (kbd "C-=") 'er/expand-region)))

;; Jump to any character with C-;
;; Jump to any line on screen with C-:
;; ace-jump-word-mode doesn't work with how I think
(use-package ace-jump-mode
  :ensure t
  :config
  (progn
    (global-set-key (kbd "C-;") 'ace-jump-char-mode)
    (global-set-key (kbd "C-:") 'ace-jump-line-mode)))

(use-package beacon
  :init (beacon-mode 1)
  :ensure t
  :config
  (progn
    (setq beacon-color "#dfbfff")))

(provide 'jws-movement)
