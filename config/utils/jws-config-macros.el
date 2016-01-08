;; I wish I remembered who created these macros; yet another thing I
;; ganked from someone else's code...

;; These macros are useful for convenience when configuring Emacs.

(defmacro after (feature &rest body)
  "After FEATURE is loaded, evaluate BODY."
  (declare (indent defun))
  `(eval-after-load ,feature
     '(progn ,@body)))

(defmacro bind (&rest commands)
  "Conveniece macro which creates a lambda interactive command."
  `(lambda ()
     (interactive)
     ,@commands))

(provide 'jws-config-macros)
