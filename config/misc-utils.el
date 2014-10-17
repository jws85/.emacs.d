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


(defun jws/get-font-cell-size ()
  "Get the size of the cell containing the currently set font; car is height, cdr is width"
  (let* ((font-vector (query-font (face-attribute 'default :font)))
	 (ascent (elt font-vector 4))
	 (descent (elt font-vector 5))
	 (average-height (+ ascent descent)) ; don't ask me, I'm not a typographer, I just grabbed this from somewhere
	 (average-width (elt font-vector 7)))
    (cons average-height average-width)))


(defun jws/emacs-frame-positioning (top-left-x top-left-y percent-wide percent-high)
  "Positions the screen to the specifications given in the arguments to this function.
This function is not interactive because it is intended that you will write a function
that fills in these arguments; you may make that interactive.

top-left-x:    Top left corner of frame, x position, in pixels
top-left-y:    Top left corner of frame, y position, in pixels
percent-wide:  Width of frame, in fraction of screen resolution
percent-high:  Height of frame, in fraction of screen resolution"
  (if window-system
      (progn
	(set-frame-position (selected-frame) top-left-x top-left-y)
	(let* ((rows-fudge-factor 3) ; we need to take about three rows off (for menubar, modeline, and minibuf)
		(font-height (car (jws/get-font-cell-size))) ; get the height of the currently set font
		(font-width (cdr (jws/get-font-cell-size))) ; get the width
		(screen-rows-high (- (/ (display-pixel-height) font-height)
				     rows-fudge-factor)) ; calculate the # of rows on screen given current font
		(screen-cols-wide (/ (display-pixel-width) font-width)) ; ditto for columns
		(frame-rows-high (floor (* percent-high screen-rows-high))) ; calculate rows for this fram
		(frame-cols-wide (floor (* percent-wide screen-cols-wide)))) ; ditto, for columns
	     (set-frame-size (selected-frame) frame-cols-wide frame-rows-high))))) ; set all of this


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


;; Color functions
; From http://www.emacswiki.org/emacs/HexColour
(defun jws/hexcolor-luminance (color)
  "Calculate the luminance of a color string (e.g. \"#ffaa00\", \"blue\").
  This is 0.3 red + 0.59 green + 0.11 blue and always between 0 and 255."
  (let* ((values (x-color-values color))
	 (r (car values))
	 (g (cadr values))
	 (b (caddr values)))
    (floor (+ (* .3 r) (* .59 g) (* .11 b)) 256)))


(defun jws/hexcolor-add-to-font-lock ()
  (interactive)
  (font-lock-add-keywords nil
			  `((,(concat "#[0-9a-fA-F]\\{3\\}[0-9a-fA-F]\\{3\\}?\\|"
				      (regexp-opt (x-defined-colors) 'words))
			     (0 (let ((color (match-string-no-properties 0)))
				  (put-text-property
				   (match-beginning 0) (match-end 0)
				   'face `((:foreground ,(if (> 128.0 (jws/hexcolor-luminance color))
							     "white" "black"))
					   (:background ,color)))))))))

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


(provide 'misc-utils)
