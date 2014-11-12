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


(defun jws/switch-to-previous-buffer ()
  "Switches to the previous buffer."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer))))


(defun jws/describe-at-point ()
  "Show the documentation of the Elisp function and variable near point.
This checks in turn:

-- for a function name where point is
-- for a variable name where point is
-- for a surrounding function call

Taken from http://www.sugarshark.com/elisp/init/lisp.el.html"
  (interactive)
  (let (sym)
    ;; sigh, function-at-point is too clever.  we want only the first half.
    (cond ((setq sym (ignore-errors
                       (with-syntax-table emacs-lisp-mode-syntax-table
                         (save-excursion
                           (or (not (zerop (skip-syntax-backward "_w")))
                               (eq (char-syntax (char-after (point))) ?w)
                               (eq (char-syntax (char-after (point))) ?_)
                               (forward-sexp -1))
                           (skip-chars-forward "`'")
                           (let ((obj (read (current-buffer))))
                             (and (symbolp obj) (fboundp obj) obj))))))
           (describe-function sym))
          ((setq sym (variable-at-point)) (describe-variable sym))
          ;; now let it operate fully -- i.e. also check the
          ;; surrounding sexp for a function call.
          ((setq sym (function-at-point)) (describe-function sym)))))


;; Quit recursive edit
; from https://github.com/davvil/.emacs.d/blob/master/init.el
(defun jws/minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))


(defun jws/animate-string-center-oneline (string &optional row)
  (let ((row (if row row (/ (frame-height) 2)))
	(col (/ (- (frame-width) (length string)) 2)))
    (animate-string string row col)))

(defun jws/animate-string-center (string)
  (let* ((lines (split-string string "\n"))
	 (currow (/ (- (frame-height) (length lines)) 2)))
    (dolist (line lines)
      (jws/animate-string-center-oneline line currow)
      (setq currow (+ currow 1)))))


(provide 'misc-utils)
