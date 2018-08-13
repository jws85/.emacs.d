;; Enable winner-mode
(winner-mode 1)

(use-package popwin
  :ensure t
  :config
  (popwin-mode))

(use-package buffer-move :ensure t)

(use-package which-key
  :ensure t
  :config
  (after 'diminish
    (diminish 'which-key-mode))

  (which-key-mode)
  (after 'diminish
    (diminish 'which-key-mode))
  (setq which-key-idle-delay 0.1))

(defhydra jws/hydra-splitting (:columns 5)
  "Buffer splitting:"
  ("TAB" other-window "Prev")

  ("s" ace-window "Jump to")
  ("h" evil-window-left "Left")
  ("j" evil-window-down "Down")
  ("k" evil-window-up "Up")
  ("l" evil-window-right "Right")

  ("H" buf-move-left "Move left")
  ("J" buf-move-down "Move down")
  ("K" buf-move-up "Move up")
  ("L" buf-move-right "Move right")

  ("-" split-window-below "Horiz split")
  ("\\" split-window-right "Vert split")
  ("|" split-window-right "Vert split")
  ("=" balance-windows "Balance splits")
  ("c" delete-window "Remove current")
  ("C" delete-other-windows "Remove others")
  ("<left>" winner-undo "Undo split")
  ("<right>" winner-redo "Redo split"))

(define-key jws/leader-map (kbd "s") 'jws/hydra-splitting/body)

(provide 'jws-window)
