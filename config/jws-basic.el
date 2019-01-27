;; I wish I remembered who created these macros; yet another thing I
;; ganked from someone else's code...

;; These macros are useful for convenience when configuring Emacs.

(defmacro after (feature &rest body)
  "After FEATURE is loaded, evaluate BODY."
  (declare (indent defun))
  `(eval-after-load ,feature
     '(progn ,@body)))

(defmacro bind (&rest commands)
  "Conveniece macro which creates a lambda interactive command."
  `(lambda ()
     (interactive)
     ,@commands))

;; I created this macro; it supersedes the previous `after` macro
(defmacro jws/after (features &rest body)
  "After FEATURES are loaded, evaluate BODY."
  (declare (indent defun))
  (if features
      `(eval-after-load ',(car features)
            (jws/after ,(cdr features) ,@body))
    `(progn ,@body)))

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
(if (functionp 'tool-bar-mode) (tool-bar-mode -1))
(if (functionp 'horizontal-scroll-bar-mode) (horizontal-scroll-bar-mode -1))
(if (functionp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (functionp 'menu-bar-mode) (menu-bar-mode -1))

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

;; Enable SCARY COMMANDS FOR ADVANCED USERS!
(put 'narrow-to-region 'disabled nil) ; C-x n n -- hide everything but selected text
(put 'narrow-to-defun 'disabled nil) ; C-x n d -- in Lisp code, hide everything but defun
(put 'dired-find-alternate-file 'disabled nil) ; In dired, don't create a gajillion friggin buffers

;; make dired more usable (lexicographic sort, human-readable sizes)
(setq dired-listing-switches "-alhv")

;; do not spawn a zillion dired buffers
(require 'dired)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))

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

;; Remove keybinding for M-j, which I never use otherwise
(global-unset-key (kbd "M-j"))

;; Disable C-x C-z; irritating keymap
(global-unset-key (kbd "C-x C-z"))

;; Define the "leader" bindings.  I have a main menu that I want to be available.
;; Generally this menu should be available from SPC in Evil Normal mode, and M-j
;; at all other times.  Remember that I unmapped M-j above.
(define-prefix-command 'jws/leader-map)
(global-set-key (kbd "M-j") jws/leader-map)
(after 'evil
  (define-key evil-normal-state-map (kbd "SPC") jws/leader-map))

;; Save place in buffers even after they are killed
(require 'saveplace)
(save-place-mode)

;; Try to force UTF-8 everywhere... even on Windows.  See this StackOverflow
;; comment:
;;   https://stackoverflow.com/a/2903256
;;
;; However, read over this, as if you are a little too strict on forcing UTF-8
;; everywhere, Windows can have problems:
;;   https://rufflewind.com/2014-07-20/pasting-unicode-in-emacs-on-windows
(setq utf-translate-cjk-mode nil ; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
      locale-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-keyboard-coding-system 'utf-8-mac) ; For old Carbon emacs on OS X only
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system
  (if (eq system-type 'windows-nt) 'utf-16-le 'utf-8))
(prefer-coding-system 'utf-8)

;; Define a hydra with some basic emacs functionality
(defun jws/server-shutdown ()
  (interactive)
  (save-some-buffers)
  (kill-emacs))

;; Basic file-handling functions
(use-package f :ensure t)

;; Load emacs' exec-path using your shell's PATH value
(use-package exec-path-from-shell
  :if (not (memq system-type '(windows-nt ms-dos)))
  :ensure t
  :config
  (exec-path-from-shell-initialize))

;; Some good functions from here that are asking for keybindings:
;;  - crux-find-user-init-file (Opens the ~/.emacs.d/init.el)
;;  - crux-find-shell-init-file (Opens your shell's init files)
;;  - crux-open-with (Opens file in your OS' default program)
(use-package crux :ensure t)

(define-key jws/leader-map (kbd "e i") 'package-install)
(define-key jws/leader-map (kbd "e s") 'server-start)
(define-key jws/leader-map (kbd "e q") 'jws/server-shutdown)
(define-key jws/leader-map (kbd "e p") 'paradox-list-packages)
(define-key jws/leader-map (kbd "e u") 'paradox-upgrade-packages)

(provide 'jws-basic)
