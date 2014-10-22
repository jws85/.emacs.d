;; This is an example file.  Please save this file to site-init.el and
;; add your site-specific customizations to that file.  You will need
;; to have at least some customizations here if you want to change
;; emacs' font, default size/position, and theme; and also if you want
;; to call external elisp or install new packages.

;;;; appearance ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; font
(set-face-attribute 'default nil :font "Consolas-11")

;; theme
(load-theme 'jellybeans t)

;; positioning/sizing code
;; I define this in a defun so I can run it without rerunning the whole ~/.emacs
(defun jws/my-emacs-frame-positioning ()
  "Positions the emacs frame to *my* personal specifications.  Interactive function.
I personally like emacs to be in the top left corner, a bit more than half the screen
wide (on a 16:9 screen) and maximized vertically as much as possible."
  (interactive)
  (jws/emacs-frame-positioning 0 0 0.57 1))

;; actually run the above
(jws/my-emacs-frame-positioning)

;;;; common lisp ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; I like QuickLisp and I find its setup for SLIME easy

;; load QuickLisp slime
(load (expand-file-name "~/.quicklisp/slime-helper.el"))

;; run Clozure CL
(setq inferior-lisp-program (expand-file-name "~/Coding/sources/ccl/lx86cl64"))
