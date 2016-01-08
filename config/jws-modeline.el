;; Not quite as sexy as airline or powerline, but neither worked particularly
;; well in Windoze anyways (too much Unicode faffery) so here we are.
(use-package smart-mode-line
  :ensure t
  :config
  (progn
    ;; Hide packages from the modeline
    (use-package diminish
      :ensure t)

    ;; Nyan~ ^_^ (in all seriousness, it's not a bad navigation indicator)
    (use-package nyan-mode
      :ensure t
      :init (nyan-mode)
      :config
      (progn
        (setq nyan-bar-length 25)))

    (column-number-mode)

    (if after-init-time (sml/setup)
      (add-hook 'after-init-hook 'sml/setup))

    ;; three places for column numbers
    (setq sml/col-number-format "%3c")

    ;; hide buffer encoding type -- I just don't need it that much
    (setq sml/mule-info "")

    ;; make filename field less wide
    (setq sml/name-width 38)

    ;; right-align the list of minor-modes
    (setq sml/mode-width 'right)))

(provide 'jws-modeline)
