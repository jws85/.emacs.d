;; Even easier than diminish -- just hide all minor modes
(use-package minions
  :ensure t
  :config
  (minions-mode 1))

;; Not quite as sexy as airline or powerline, but neither worked particularly
;; well in Windoze anyways (too much Unicode faffery) so here we are.
(use-package smart-mode-line
  :ensure t
  :config
  ;; Nyan~ ^_^ (in all seriousness, it's not a bad navigation indicator)
  (use-package nyan-mode
    :ensure t
    :config
    (setq nyan-bar-length 25))

  (column-number-mode)

  (setq sml/col-number-format "%3c" ; three places for column numbers
        sml/mule-info "" ; hide buffer encoding type -- I just don't need it that much
        sml/name-width 38 ; make filename field less wide
        sml/mode-width 'right ; right-align the list of minor-modes
        sml/theme 'respectful)

  (if after-init-time (sml/setup)
    (nyan-mode)
    (add-hook 'after-init-hook 'sml/setup)))

(provide 'jws-modeline)
