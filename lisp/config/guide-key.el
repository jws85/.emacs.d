(use-package guide-key
  :init (guide-key-mode 1)
  :ensure t
  :config
  (progn
    (after 'diminish
      (diminish 'guide-key-mode))

    (setq guide-key/guide-key-sequence '("C-x" "C-h" "M-g" "C-c" ",")
	  guide-key/recursive-key-sequence-flag t
	  guide-key/idle-delay 0.5)))

(provide 'config/guide-key)
