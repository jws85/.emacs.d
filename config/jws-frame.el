;; Code to handle frame size and position, based on the currently
;; selected font

;; Positioning code:
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

(defvar jws/default-width-percent 0.5 "The percentage width of the screen of the emacs frame")
(defvar jws/default-height-percent 1 "The percentage height of the screen of the emacs frame")

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
  (jws/set-default-frame-alist jws/default-x-pos jws/default-y-pos
                                  jws/default-width-percent jws/default-height-percent
                                  jws/default-font))

(defun jws/set-default-frame-alist (px-x px-y percent-wide percent-high &optional font-name)
  "Sets default emacs frame size.

PX-X and PX-Y are the x/y-coordinates, in pixels, starting from the top left
corner.

PERCENT-WIDE and PERCENT-HIGH must be floating-point numbers between 0 and 1.

FONT-NAME is some kind of string understood by Emacs as a font.  The easiest
for me is the Xft format, which is usually like 'Consolas-11'."
  (if window-system
      (progn
	(let* ((rows-fudge-factor 3) ; we need to take about three rows off (for menubar, modeline, and minibuf)
               (font-height (car (jws/get-font-cell-size font-name))) ; get the height of the currently set font
               (font-width (cdr (jws/get-font-cell-size font-name))) ; get the width
               (screen-rows-high (- (/ (display-pixel-height) font-height)
                                    rows-fudge-factor)) ; calculate the # of rows on screen given current font
               (screen-cols-wide (/ (display-pixel-width) font-width)) ; ditto for columns
               (frame-rows-high (floor (* percent-high screen-rows-high))) ; calculate rows for this fram
               (frame-cols-wide (floor (* percent-wide screen-cols-wide)))) ; ditto, for columns

          ;; Print a message, because otherwise I found it hard to debug!
          (message "Current font is %s" (elt (query-font (face-attribute 'default :font)) 0))
          (message "Setting frame to %d columns wide, %d rows high, at (%d, %d)!"
                   frame-cols-wide frame-rows-high px-x px-y)

          ;; And here we actually set those values!
          (if (not (eq font-name nil))
              (add-to-list 'default-frame-alist `(font . ,font-name)))
          (add-to-list 'default-frame-alist `(left . ,px-x))
          (add-to-list 'default-frame-alist `(top . ,px-y))
          (add-to-list 'default-frame-alist `(width . ,frame-cols-wide))
          (add-to-list 'default-frame-alist `(height . ,frame-rows-high))))))

;; The font vector returned by query-font is not the same as the
;; one returned by font-info... I will refrain from commenting on
;; things I barely understand, but I don't understand why it is
;; done this way!

(defun jws/get-font-cell-size (&optional font-name)
  "Get the size of the cell containing the currently set font.

FONT-NAME is some kind of string understood by Emacs as a font.

The car of the returned cons cell is height, cdr is width."
  (if (eq font-name nil)
      (jws/-get-current-frame-font-specs)
    (jws/-get-named-font-specs font-name)))

(defun jws/-get-current-frame-font-specs ()
  (let* ((font-vector (query-font (face-attribute 'default :font)))
         (ascent (elt font-vector 4))
         (descent (elt font-vector 5))
         (average-width (elt font-vector 7)))
    (cons (+ ascent descent) average-width)))

(defun jws/-get-named-font-specs (font-name)
  (let* ((font-vector (font-info font-name))
         (ascent (elt font-vector 8))
         (descent (elt font-vector 9))
         (average-width (elt font-vector 11)))
    (cons (+ ascent descent) average-width)))

;; And after doing all of that, do an initial setting of these
;; values!  To override this, change the jws/default-* and rerun
;; the below function in your site-init.el:

(jws/set-my-default-frame-alist)

;; Hydra to create, close, and resize frames

(after 'hydra
  (defhydra jws/hydra-frame (:exit t)
    ("n" make-frame "Make new window/frame")
    ("c" delete-frame "Close window/frame")

    ("d" jws/use-default-frame-alist "Default position/size/font")
    ("m" toggle-frame-maximized "Maximize/unmaximize")
    ("f" toggle-frame-fullscreen "Toggle fullscreen"))

  (global-set-key (kbd "M-j w") 'jws/hydra-frame/body)
  (after 'evil
    (define-key evil-normal-state-map (kbd "SPC w") 'jws/hydra-frame/body)))

(provide 'jws-frame)
