;; Sets up fontification settings, e.g. themeing, font size...

(defun jws/text-scale-reset ()
  "Reset text scale."
  (interactive)
  (text-scale-set 0))

;; Focus on some text at a time
(use-package focus :ensure t)

;; Wrap all this together into keybindings
(after 'hydra
  (defhydra jws/hydra-themeing ()
    ("f" focus-mode "Focus")
    ("t" load-theme "Load theme")

    ("=" jws/text-scale-reset "Reset font size")
    ("r" jws/text-scale-reset "Reset font size")

    ("+" text-scale-increase "Larger font")
    ("l" text-scale-increase "Larger font")

    ("-" text-scale-decrease "Smaller font")
    ("s" text-scale-decrease "Smaller font"))

  (global-set-key (kbd "C-c C-c t") 'jws/hydra-themeing/body)
  (after 'evil
    (define-key evil-normal-state-map (kbd ", t") 'jws/hydra-themeing/body)))

(provide 'jws-themeing)
