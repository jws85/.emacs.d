(require 'opascal)

;; I've been playing around with Lazarus and Free Pascal.
;; While it isn't the nicest language environment, it does make some
;; nice cross-platform executables with a minimum of fuss.

; Unit files
(add-to-list 'auto-mode-alist '("\\.pas$" . opascal-mode))

; Window description
(add-to-list 'auto-mode-alist '("\\.lfm$" . opascal-mode))

; Entry point
(add-to-list 'auto-mode-alist '("\\.lpr$" . opascal-mode))

(provide 'jws-pascal)
