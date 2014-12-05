;; This is an example file.  Please save this file to site-init.el and
;; add your site-specific customizations to that file.  You will need
;; to have at least some customizations here if you want to change
;; emacs' font, default size/position, and theme; and also if you want
;; to call external elisp or install new packages.

;;;; Appearance ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; font
(set-face-attribute 'default nil :font "Consolas-11")

;; theme
(load-theme 'jellybeans t)

;; positioning/sizing code
;; I define this in a defun so I can run it without rerunning the whole ~/.emacs
(require 'jws/frame-size)
(defun jws/my-emacs-frame-positioning ()
  "Positions the emacs frame to *my* personal specifications.  Interactive function.
I personally like emacs to be in the top left corner, a bit more than half the screen
wide (on a 16:9 screen) and maximized vertically as much as possible."
  (interactive)
  (jws/emacs-frame-positioning 0 0 0.57 1))

;; actually run the above
(jws/my-emacs-frame-positioning)

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
(require 'jws/path-helpers)
(setq org-agenda-files
      (jws/expand-file-names (list "todo.org") "~/org"))
