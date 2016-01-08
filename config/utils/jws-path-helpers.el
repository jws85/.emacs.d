(defun jws/expand-file-names (files path)
  "Expand all file names in FILES with folder path PATH"
  (mapcar (lambda (fn)
	    (expand-file-name fn path))
	  files))

(provide 'jws-path-helpers)
