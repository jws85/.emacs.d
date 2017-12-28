;;;; jws' .emacs
;;
;;; Warning:  Opinionated code follows! --------------------------------
;;
;; It goes without saying that this file assumes you like Vim
;; keybindings.  If you don't like them, find another .emacs.  (Or
;; strip out the evil stuff.)
;;
;; This code used to have some pretense towards cross-platform-ness,
;; but honestly Windows Emacs (and Windows Vim, and Windows anything-
;; other-than-Visual-Studio) is kind of a wash, too much stuff needs
;; to be removed or avoided because it's not super interoperable with
;; the GNU userland tools.  These days, it's easier to just run Xming
;; under Windows and run Emacs in a Linux VM.
;;
;; Feel free to steal from this, a lot of this was stolen as well
;; (though I try to give credit where due).

;;;; Global variables ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar jws/emacs-backup-dir (expand-file-name (concat user-emacs-directory ".cache/backups"))
  "The directory that emacs uses to store backup files to")

(defvar jws/emacs-desktop-dir (expand-file-name (concat user-emacs-directory ".cache/desktop"))
  "The directory that emacs uses to store .desktop files in")

(defvar jws/emacs-config-dir (expand-file-name (concat user-emacs-directory "config"))
  "The directory where my Emacs config lives")

(defvar jws/emacs-library-dir (expand-file-name (concat user-emacs-directory "lisp"))
  "The directory where various unpackaged libraries are living")

(defvar jws/emacs-site-library-dir (expand-file-name (concat user-emacs-directory "site-lisp"))
  "The directory where various site-specific unpackaged libraries are living")

(defvar jws/emacs-color-dir (expand-file-name (concat user-emacs-directory "colors"))
  "The directory where deftheme color themes live")

;;;; Fundamental basic stuff ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Add config directory recursively
(let ((default-directory jws/emacs-config-dir))
  (add-to-list 'load-path default-directory)
  (normal-top-level-add-subdirs-to-load-path))
(require 'jws-basic)

;; Add library directory recursively
(let ((default-directory jws/emacs-library-dir))
  (add-to-list 'load-path default-directory)
  (normal-top-level-add-subdirs-to-load-path))

(if (file-exists-p jws/emacs-site-library-dir)
    (let ((default-directory jws/emacs-site-library-dir))
      (add-to-list 'load-path default-directory)
      (normal-top-level-add-subdirs-to-load-path)))

(add-to-list 'custom-theme-load-path jws/emacs-color-dir)

;;;; Package management ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'jws-package-mgmt)

;;;; Packages: Basic text editing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'jws-vi)         ; Evil and other vi-style things
(require 'jws-movement)   ; Other plugins to help move around
(require 'jws-indent)     ; Indentation
(require 'jws-completion) ; Text completion
(require 'jws-modeline)   ; The bar at the bottom with data in it

;;;; Packages: Editor navigation ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'jws-searching)  ; "Searching" UIs (ido/helm)
(require 'jws-project)    ; Project management

;;;; Packages: Languages ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'jws-lisp)
(require 'jws-markup)
(require 'jws-tex)
(require 'jws-clangs)
(require 'jws-web-langs)

;;;; Packages: Miscellaneous ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'jws-themeing)
(require 'jws-splashscreen)
(require 'jws-fonts)
(require 'jws-guide-key)
(require 'jws-org-mode)
(require 'jws-calc)
(require 'jws-www)        ; web integration
(require 'jws-vcs)        ; version control integration
(require 'jws-window)
(require 'jws-docs)
(require 'jws-session)
(require 'jws-utils)

;;;; Site-specific customizations ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; I need certain settings at work, etc.
;; The T arg means to ignore not being able to find the file --
;; no need to barf if there's no site-init stuff.
(load site-file t)

;;;; Custom ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Remembered how to move that junk out of this file -- it's cluttered
;; enough without machine-generated elisp junk lying around.
(load custom-file t)
