(defun jws/expand-file-names (files path)
  "Expand all file names in FILES with folder path PATH"
  (mapcar (lambda (fn)
	    (expand-file-name fn path))
	  files))

(defun jws/directory-files (path absolute)
  "Return all files (not including . or ..) in PATH.

If ABSOLUTE is non-nil, return an absolute path; otherwise, just return
the filename."
  (directory-files (expand-file-name path) absolute "^\\([^.]\\|\\.[^.]\\|\\.\\..\\)"))

(provide 'jws-path-helpers)
