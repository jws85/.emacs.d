;;; jws-calc.el -- Site-specific initialization file

;;; Commentary:

;;; Code:

(define-key jws/leader-map (kbd "c") 'calc)

;; Add computer data units
;; see https://florian.adamsky.it/2016/03/31/emacs-calc-for-programmers-and-cs.html
(setq math-additional-units
      '((bit nil "Bit")
        (byte "8 * bit" "Byte")
        (bps "bit / s" "Bytes per second"))
      math-units-table nil)

;; Load currency units into Emacs Calc
(require 'calc-currency)
(setq calc-currency-exchange-rates-file (expand-file-name (concat user-emacs-directory ".cache/calc-currency-rates.el"))
      calc-currency-update-interval 3)
(setq calc-start-hook #'calc-currency-load)

(provide 'jws-calc)

;;; jws-calc.el ends here
