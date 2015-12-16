;;;; jws' .emacs
;;
;; I used emacs for about four years, through most of college.  Then
;; when I finally got a job, I switched to vim.  90% of it was because
;; nXhtml's auto-indentation was all too happy to muck up the awful
;; indentation in our old PHP code, and I couldn't figure out how to
;; disable it for certain file types.
;;
;; So I moved to the Dark Side and grew powerful there.  I found how
;; amazing the keybindings were, how many great plugins there were,
;; how many awesome colorschemes.
;;
;; But there was something missing.  I caught a glimmer of it every
;; time a vim plugin needed to call something externally, or every
;; time I tried to hack Lisp with vim[1].  I knew I needed to go back.
;;
;; I followed the progress of the nice folks making Evil[2] happen,
;; and when it seemed like it was emulating 99% of Vim (not that ratty
;; old Vi junk that Viper does) I decided that I would try Emacs
;; again.  So here I am.
;;
;; [1] Note that Paul Graham of viaweb and ycombinator fame does use
;;     vim to hack Common Lisp.  He's like one of a handful of people
;;     who do so.
;;
;; [2] https://gitorious.org/evil/pages/Home
;;
;;; Warning:  Opinionated code follows! --------------------------------
;;
;; It goes without saying that this file assumes you like Vim
;; keybindings.  If you don't like them, find another .emacs.  (Or
;; strip out the evil stuff.)
;;
;; This file is intended to be crossplatform.  I use Linux at work and
;; currently Windows at home (so I enjoy games!  quelle horror!) and
;; I'd like this to function in both.
;;
;; All of the code I've cooked up for this is prefixed with jws/ as a
;; way of crude C-style namespacing -- did elisp ever get namespacing
;; while I was gone?
;;
;; Feel free to steal from this, a lot of this was stolen as well
;; (though I try to give credit where due).

;;;; Global variables ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar jws/emacs-backup-dir (expand-file-name (concat user-emacs-directory ".cache/backups"))
  "The directory that emacs uses to store backup files to")

(defvar jws/emacs-library-dir (expand-file-name (concat user-emacs-directory "lisp"))
  "The directory where various unpackaged libraries (some of which I may have written) are living")

(defvar jws/emacs-color-dir (expand-file-name (concat user-emacs-directory "colors"))
  "The directory where deftheme color themes live")

;;;; Fundamental basic stuff ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Add library directory recursively
(let ((default-directory jws/emacs-library-dir))
  (add-to-list 'load-path default-directory)
  (normal-top-level-add-subdirs-to-load-path))
(require 'config/misc-utils)
(require 'config/basic)

(add-to-list 'custom-theme-load-path jws/emacs-color-dir)

;;;; Package management ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; a.k.a. the best thing to ever happen to emacs
(require 'use-package)
(require 'package)

;; MELPA (forget Marmalade, it never worked for me)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; Enable packages
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))


;;;; Packages: Basic text editing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'config/vi)         ; Evil and other vi-style things
(require 'config/movement)   ; Other plugins to help move around
(require 'config/indent)     ; Indentation
(require 'config/completion) ; Text completion
(require 'config/modeline)   ; The bar at the bottom with data in it

;;; Packages: Editor navigation ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'config/searching)  ; "Searching" UIs (ido/helm)
;(require 'config/project)    ; Project management

;;;; Packages: Languages ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'config/lisp)
(require 'config/markup)
(require 'config/tex)
(require 'config/clangs)
(require 'config/web-langs)

;;;; Packages: Miscellaneous ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'config/guide-key)
(require 'config/org-mode)
(require 'config/www)        ; web integration
(require 'config/vcs)        ; version control integration
(require 'config/popwin)
(require 'config/package-mgmt)
(require 'config/docs)

;;;; Site-specific customizations ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; I need certain settings at work, etc.
;; The T arg means to ignore not being able to find the file --
;; no need to barf if there's no site-init stuff.
(load site-file t)

;;;; Custom ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Remembered how to move that junk out of this file -- it's cluttered
;; enough without machine-generated elisp junk lying around.
(load custom-file t)
