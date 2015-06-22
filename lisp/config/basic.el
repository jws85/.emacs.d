;; I think most machines I'm on nowadays have at least 2GB of RAM.
;; Read 'GC Optimization' here:  https://github.com/lewang/flx
(setq gc-cons-threshold 20000000)

;; Site-specific customization file, loaded at the end of init.el
(setq site-file (expand-file-name (concat user-emacs-directory "site-init.el")))

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
    (make-directory jws/emacs-backup-dir t))

;; Change where backups are done
(setq backup-directory-alist `(("." . ,jws/emacs-backup-dir)))

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

;; Disable auto-save.  Sometimes I just want to not save my changes to a
;; file.  This "feature" of emacs just frustrates that to all hell.
(setq auto-save-default nil)

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

;; Always put point in the help window
(setq help-window-select t)

;; It's nice to just timestamp things, though git is increasingly
;; deprecating the uses of something like this.
(add-hook 'before-save-hook 'time-stamp)

;; Treats all themes as safe to load.  I may need to play with this or move
;; it into site-init.el
(setq custom-safe-themes t)

;; I like being able to narrow the display.  This is considered an advanced
;; "confusing" feature... so I'll explain.  You can highlight text and type
;; C-x n n to only display that text e.g. to only search that bit.  I like
;; it as a way to focus.  You can widen with C-x n w.  In Lisp code, C-x n d
;; narrows to the current defun.
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-defun 'disabled nil)

;; make dired more usable (lexicographic sort, human-readable sizes)
(setq dired-listing-switches "-alhv")

;; don't make me have to type out 'yes' or 'no'
(fset 'yes-or-no-p 'y-or-n-p)

;; I prefer yyyy-mm-dd to mm/dd/yyyy
(setq calendar-date-style 'iso)

;; Make files with shebangs (#!) executable
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; Highlight matching paren
(require 'paren)
(show-paren-mode)

;; Force the major-mode to refontify/rehighlight the text in the buffer
;; Needed for complicated modes like web-mode
(global-set-key (kbd "<f12>") 'font-lock-fontify-buffer)

(provide 'config/basic)
