;; This Microsoft font works surprisingly nicely on Linux as well!
(set-face-attribute 'default nil :font "Consolas-11")

(setq custom-safe-themes t)

;; I made a deftheme clone of the Vim theme 'Jellybeans'
(load-theme 'jellybeans t)

;; Set up my specific positioning requirements
(defun jws/my-emacs-frame-positioning ()
  "Positions the emacs frame to *my* personal specifications.  Interactive function.
I personally like emacs to be in the top left corner, a bit more than half the screen
wide (on a 16:9 screen) and maximized vertically as much as possible."
  (interactive)
  (jws/emacs-frame-positioning 0 0 0.57 1))
  
;; Actually run the positioning code
(jws/my-emacs-frame-positioning)

;; Line numbers
(global-linum-mode 1)
(setq-default linum-format "%4d")

(provide 'init-appearance)
