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

(provide 'config/misc-utils)
