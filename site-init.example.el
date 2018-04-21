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

;; theme
(load-theme 'jellybeans t)

;; If you want to position the window, you'll need to open up a GUI frame
;; and run (jws/calculate-window-size), then take those values and enter
;; them here and re-run (jws/set-my-default-frame-alist):
;; (setq jws/default-x-pos 50)
;; (setq jws/default-width-colums 120)
;; (setq jws/default-height-rows 50)
;; (setq jws/default-font "PragmataPro-10.5")
;; (jws/set-my-default-frame-alist)

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
