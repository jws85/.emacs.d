;; Session management

;;;; The following code was stolen from https://www.emacswiki.org/emacs/Desktop#toc4
;;;; What it does is:  whenever emacs ends abnormally (it crashes, the system crashes,
;;;; or when I shut down without shutting Emacs down), I get stuck with a stale lock
;;;; on the desktop file, which is irritating.
;;;;
;;;; So this should attempt to remove the dead lock file and load anyways.
(defun emacs-process-p (pid)
  "If pid is the process ID of an emacs process, return t, else nil.
Also returns nil if pid is nil."
  (when pid
    (let ((attributes (process-attributes pid)) (cmd))
      (dolist (attr attributes)
        (if (string= "comm" (car attr))
            (setq cmd (cdr attr))))
      (if (and cmd (or (string= "emacs" cmd) (string= "emacs.exe" cmd))) t))))

(defadvice desktop-owner (after pry-from-cold-dead-hands activate)
  "Don't allow dead emacsen to own the desktop file."
  (when (not (emacs-process-p ad-return-value))
    (setq ad-return-value nil)))
;;;; end emacswiki code

;; Create directory
(if (not (file-exists-p jws/emacs-desktop-dir))
    (make-directory jws/emacs-desktop-dir t))

(setq desktop-dirname             jws/emacs-desktop-dir
      desktop-base-file-name      "emacs.desktop"
      desktop-base-lock-name      "lock"
      desktop-path                (list desktop-dirname)
      desktop-save                t
      desktop-files-not-to-save   "^$" ;reload tramp paths
      desktop-load-locked-desktop nil)

;; Always save the session
(desktop-save-mode 1)

;; This should go through my buffers once a day, early in the morning,
;; and get rid of a lot of cruft (any buffer older than three days
;; old, plus temp buffer junk) BTW, if I'm up at 3:30 AM, something is
;; seriously wrong.
(require 'midnight)
(midnight-delay-set 'midnight-delay "3:30 AM")

(provide 'jws-session)
