;; Vi-only keybinding
(after 'evil (define-key evil-normal-state-map (kbd ", c") 'calc))

;; Add computer data units
;; see https://florian.adamsky.it/2016/03/31/emacs-calc-for-programmers-and-cs.html
(setq math-additional-units
      '((bit nil "Bit")
        (byte "8 * bit" "Byte")
        (bps "bit / s" "Bytes per second"))
      math-units-table nil)

(provide 'jws-calc)
