;; I think most machines I'm on nowadays have at least 2GB of RAM.
;; Read 'GC Optimization' here:  https://github.com/lewang/flx
(setq gc-cons-threshold 20000000)

;; I hate having the machine-generated 'custom' values in init.el and
;; prefer them to be... anywhere else!  I try to migrate custom.el
;; settings into other files so I can have more control over it, but
;; some functionality like per-project dir-locals settings, need to
;; use custom in order to keep track of 'safe' settings, and I like
;; dir-locals more than I hate custom.
;;
;; FYI:  Using .dir-locals.el in projects, I find that if you aren't
;; explicitly setting the custom.el to the custom.el in emacs' directory,
;; emacs will happily barf custom.el files all over when you read in a
;; file that needs the .dir-locals.el settings.
(setq custom-file (expand-file-name (concat user-emacs-directory "custom.el")))

;; Create directory to back up to
(if (not (file-exists-p jws/emacs-backup-dir))
    (make-directory jws/emacs-backup-dir))

;; Create directory to autosave to
(if (not (file-exists-p jws/emacs-auto-save-dir))
    (make-directory jws/emacs-auto-save-dir))

;; Change where backups/auto-saves are done
(setq backup-directory-alist `(("." . ,jws/emacs-backup-dir)))
(setq auto-save-file-name-transforms `((".*" ,jws/emacs-auto-save-dir t)))

;; Backup by copying files
(setq backup-by-copying t)

;; Prune old backups
(setq delete-old-versions t)

;; Control how many old backups are kept
(setq kept-old-versions 6)
(setq kept-new-versions 2)

;; Always number the backups
(setq version-control t)

;; Make backup files, even if the file's in version control
(setq vc-make-backup-files t)

;; ring my bee-eeee-eeellll, ring my bell
;; how about no.  it's not 1979 anymore, we don't need this anymore
(setq ring-bell-function 'ignore) ; turn the freaking bell off

;; vim-style line-by-line scrolling
(setq scroll-step 1)
(setq scroll-conservatively 10000)

;; Remove all of these awful toolbars.  Emacs is made to be mouseless.
(tool-bar-mode -1)    ; remove big-ass toolbar
(scroll-bar-mode -1)  ; remove scrollbar
(menu-bar-mode -1)    ; remove menu bar

;; I've used emacs for probably the better part of a decade now.  I know
;; how to get help and all that. (coughgooglecough)
(setq inhibit-startup-message t) ; hide startup screen

;; It's nice to just timestamp things, though git is increasingly
;; deprecating the uses of something like this.
(add-hook 'before-save-hook 'time-stamp)

(provide 'init-basic)
