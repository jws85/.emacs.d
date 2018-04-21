;; Centers multiline animated text
;; Intended for startup and the like

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

;; Dashboard

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((agenda . 5)
                          (projects . 5)
                          (recents . 5))))

(provide 'jws-splashscreen)
