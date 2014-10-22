;; Not quite as sexy as airline or powerline, but neither worked particularly
;; well in Windoze anyways (too much Unicode faffery) so here we are.
;;
;; I need to rein in my tendency to make my emacs (ugh) 'lickable' as it were.
;; It's out of the 70s anyways, it should look like it!
(use-package smart-mode-line
  :ensure t
  :config
  (progn
    (use-package diminish :ensure t)

    (column-number-mode)

    (if after-init-time (sml/setup)
      (add-hook 'after-init-hook 'sml/setup))

    ;; three places for column numbers
    (setq sml/col-number-format "%3c")

    ;; right-align the list of minor-modes
    (setq sml/mode-width 'right)))

(provide 'init-smart-mode-line)
