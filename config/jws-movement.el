;; Select increasingly large areas of text with C-=
(use-package expand-region
  :ensure t
  :config
  (progn
    (global-set-key (kbd "C-=") 'er/expand-region)))

;; Jump to any character with C-;
;; Jump to any line on screen with C-:
(use-package avy
  :ensure t
  :config
  (progn
    (global-set-key (kbd "C-;") 'avy-goto-char)
    (global-set-key (kbd "C-:") 'avy-goto-line)))

(use-package beacon
  :init (beacon-mode 1)
  :ensure t
  :config
  (progn
    (setq beacon-color "#dfbfff")))

(provide 'jws-movement)
