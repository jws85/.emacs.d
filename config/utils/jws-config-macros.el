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

;; I created this macro; it supersedes the previous `after` macro
(defmacro jws/after (features &rest body)
  "After FEATURES are loaded, evaluate BODY."
  (declare (indent defun))
  (if features
      `(eval-after-load ',(car features)
            (jws/after ,(cdr features) ,@body))
    `(progn ,@body)))

(provide 'jws-config-macros)
