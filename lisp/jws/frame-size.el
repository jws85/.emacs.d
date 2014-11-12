;; Code to handle frame size and position, based on the currently
;; selected font

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

(defun jws/get-font-cell-size ()
  "Get the size of the cell containing the currently set font; car is height, cdr is width"
  (let* ((font-vector (query-font (face-attribute 'default :font)))
	 (ascent (elt font-vector 4))
	 (descent (elt font-vector 5))
	 (average-height (+ ascent descent)) ; don't ask me, I'm not a typographer, I just grabbed this from somewhere
	 (average-width (elt font-vector 7)))
    (cons average-height average-width)))

(provide 'jws/frame-size)
