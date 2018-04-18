;; Code to handle frame size and position, based on the currently
;; selected font

;; Positioning code:
;;
;; Originally this tried to be "smart" and used the font
;; information in e.g. face-attribute to figure out how big the
;; window needed to be.  But that unfortunately doesn't work
;; without a GUI frame, and I wanted to move to a completely
;; daemonized Emacs setup.
;;
;; So, the "smart" code now lives in jws/calculate-frame-size,
;; and we just set a default-frame-alist with some sane defaults
;; (top-left corner, 100x35 characters, and a sane font for the
;; current OS).  The idea is to launch a GUI frame, run
;; jws/calculate-frame-size, and put those settings in
;; site-lisp.el.

;; - jws/set-default-frame-alist sets the default frame size to a
;;   given size.
;; - jws/set-my-default-frame-alist sets the default frame size as
;;   specified by the defvar options below.
;; - jws/use-default-frame-alist sets the current frame to that
;;   default frame size (interactive function).
;; - jws/get-font-cell-size directly queries the current font to
;;   find some kind of relationship between row/cols and pixel
;;   sizes

(defvar jws/default-x-pos 0 "The x-coordinate (in px from top-left corner) to place emacs frame")
(defvar jws/default-y-pos 0 "The y-coordinate (in px from top-left corner) to place emacs frame")

(defvar jws/default-width-columns 100 "The default width, in columns of characters")
(defvar jws/default-height-rows 35 "The default height, in rows of characters")

;; Sane defaults.  I do not use Macs...
(defvar jws/default-font "DejaVu Sans Mono-10.5")
(if (or (equal system-type 'windows-nt) (equal system-type 'ms-dos))
    (setq jws/default-font "Consolas-11"))

(defun jws/use-default-frame-alist ()
  "Sets emacs frame to the default frame size."
  (interactive)
  (set-frame-font (cdr (assq 'font default-frame-alist)))
  (set-frame-position (selected-frame)
                      (cdr (assq 'top default-frame-alist))
                      (cdr (assq 'left default-frame-alist)))
  (set-frame-size (selected-frame)
                  (cdr (assq 'width default-frame-alist))
                  (cdr (assq 'height default-frame-alist))))

(defun jws/set-my-default-frame-alist ()
  "Sets default emacs frame size to *my* personal specifications."
  (delete (assq 'font default-frame-alist) default-frame-alist)
  (add-to-list 'default-frame-alist `(font . ,jws/default-font))
  (delete (assq 'left default-frame-alist) default-frame-alist)
  (add-to-list 'default-frame-alist `(left . ,jws/default-x-pos))
  (delete (assq 'top default-frame-alist) default-frame-alist)
  (add-to-list 'default-frame-alist `(top . ,jws/default-y-pos))
  (delete (assq 'width default-frame-alist) default-frame-alist)
  (add-to-list 'default-frame-alist `(width . ,jws/default-width-columns))
  (delete (assq 'height default-frame-alist) default-frame-alist)
  (add-to-list 'default-frame-alist `(height . ,jws/default-height-rows)))

(defun jws/calculate-frame-size (percent-wide percent-high)
  "Calculates size for Emacs frame.

This is an interactive command, and should be run from a GUI frame
only, as font-querying commands cannot be run from terminal emacs
frames.  (What an irritating limitation!)

PERCENT-WIDE and PERCENT-HIGH must be floating-point numbers between 0
and 1."
  (interactive "nPercent width (0 to 1): \nnPercent height (0 to 1): ")
  (if window-system
      (let* ((rows-fudge-factor 3) ; we need to take about three rows off (for menubar, modeline, and minibuf)
             (font-height (car (jws/get-current-frame-font-specs))) ; get height of current font
             (font-width (cdr (jws/get-current-frame-font-specs))) ; get width
             (screen-rows-high (- (/ (display-pixel-height) font-height)
                                  rows-fudge-factor)) ; calculate the # of rows on screen given current font
             (screen-cols-wide (/ (display-pixel-width) font-width)) ; ditto for columns
             (frame-rows-high (floor (* percent-high screen-rows-high))) ; calculate rows for this fram
             (frame-cols-wide (floor (* percent-wide screen-cols-wide)))) ; ditto, for columns

        (message "Set your frame to %d columns wide and %d rows high."
                 frame-cols-wide frame-rows-high))
    (message "This command should be run from a GUI frame, sorry...")))

(defun jws/get-current-frame-font-specs ()
  (let* ((font-vector (query-font (face-attribute 'default :font)))
         (ascent (elt font-vector 4))
         (descent (elt font-vector 5))
         (average-width (elt font-vector 7)))
    (cons (+ ascent descent) average-width)))

(jws/set-my-default-frame-alist)

;; Hydra to create, close, and resize frames

(after 'hydra
  (defhydra jws/hydra-frame (:exit t)
    ("n" make-frame "Make new window/frame")
    ("c" delete-frame "Close window/frame")

    ("d" jws/use-default-frame-alist "Default position/size/font")
    ("x" jws/calculate-frame-size "Calculate size via current font")
    ("m" toggle-frame-maximized "Maximize/unmaximize")
    ("f" toggle-frame-fullscreen "Toggle fullscreen"))

  (define-key jws/leader-map (kbd "w") 'jws/hydra-frame/body))

(provide 'jws-frame)
