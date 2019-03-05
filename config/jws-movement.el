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
    (global-set-key (kbd "C-'") 'avy-goto-char)
    (global-set-key (kbd "C-\"") 'avy-goto-line)))

(use-package ace-window
  :ensure t
  :config
  (progn
    ;; Replace evil's C-w C-w default with ace-window
    (after 'evil
      (define-key evil-normal-state-map (kbd "C-w <SPC>") 'evil-window-next)
      (define-key evil-normal-state-map (kbd "C-w C-w") 'ace-window))))

(use-package beacon
  :init (beacon-mode 1)
  :disabled
  :ensure t
  :config
  (progn
    (setq beacon-color "#dfbfff")))

(provide 'jws-movement)
