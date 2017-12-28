;; This is an example file.  Please save this file to site-init.el and
;; add your site-specific customizations to that file.  You will need
;; to have at least some customizations here if you want to change
;; emacs' font, default size/position, and theme; and also if you want
;; to call external elisp or install new packages.

;;;; Splashscreen ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(with-eval-after-load 'dashboard
  (setq dashboard-banner-logo-title "Welcome to Emacs"))

;;;; Location ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Needed to get the (require 'solar) functions working
;; Not my real location, lol, unless I'm the High Rock Lake Monster :P

(setq calendar-latitude [35 39 north])
(setq calendar-longitude [80 18 west])

;;;; Appearance ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; font
(set-face-attribute 'default nil :font "Consolas-11")

;; theme
(load-theme 'jellybeans t)

;; positioning/sizing code
;; I define this in a defun so I can run it without rerunning the whole ~/.emacs
(require 'jws-frame-size)
(defun jws/my-emacs-frame-positioning ()
  "Positions the emacs frame to *my* personal specifications.  Interactive function.
I personally like emacs to be in the top left corner, a bit more than half the screen
wide (on a 16:9 screen) and maximized vertically as much as possible."
  (interactive)
  (jws/emacs-frame-positioning 0 0 0.57 1))

;; actually run the above
(jws/my-emacs-frame-positioning)

;; Prevent window from splitting unless it has a lot of columns
;; The default is 160.  On a 1080p screen with the above positioning code
;; and certain fonts, this can be annoying, and so I set it to 200 to prevent
;; splitting.  On smaller screens this will need some experimentation.
(setq split-width-threshold 160)

;;;; A note ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Please note that this file is not just for your appearance-related
;; customization.  If you want to install packages of your own, stick them
;; in this file using (use-package :ensure t).
;;
;; Or you could load external packages.  Quicklisp comes with a SLIME helper
;; that installs it inside Quicklisp itself.  Easy, but not easy to keep
;; consistent between environments.

;; For instance:

;; Setting up org-agenda (could swap out ~/org for d:/org or whatever)
(require 'jws-path-helpers)
(setq org-agenda-files
      (jws/expand-file-names (list "todo.org") "~/org"))
