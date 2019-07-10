;;; jws-calc.el -- Site-specific initialization file

;;; Commentary:

;; By default, calc settings should go under ~/.emacs.d/calc.el
;; But that file seems to be used by Calc itself to store various
;; user settings -- as such, it might be better to use that as a
;; machine-specific, non-version-controlled file

;;; Code:

(define-key jws/leader-map (kbd "c") 'calc-dispatch)

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

;; Favorite units are all currency:
;;  u 1: US dollar
;;  u 2: Canadian dollar
;;  u 3: Australian dollar
;;  u 4: Mexican peso
;;  u 5: Euro
;;  u 6: Japanese yen
;;  u 7: Chinese yuan/renminbi
;;  u 8: Hong Kong dollar
;;  u 9: Singaporean dollar
;;  u 0: South Korean won
(setq var-Units (calc-eval "[USD, CAD, AUD, MXN, EUR, JPY, CNY, HKD, SGD, KRW]" 'raw))

(provide 'jws-calc)

;;; jws-calc.el ends here
