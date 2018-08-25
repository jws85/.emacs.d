;; Image viewing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package image+
  :ensure t
  :config
  (eval-after-load 'image '(require 'image+)))

;; Dired ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun jws/dired-home ()
  (interactive)
  (dired "~"))

(define-key jws/leader-map (kbd "u d") 'jws/dired-home)

;; Show/hide hidden files
(require 'dired-x)
(setq dired-omit-files "^\\...+$")
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode 1)))
(define-key dired-mode-map (kbd ", h") 'dired-omit-mode)

;; make-it-so, a package to perform batch file conversions with dired
(use-package make-it-so
  :ensure t
  :init (require 'make-it-so)
  :config
  (progn
    (setq mis-recipes-directory (expand-file-name (concat user-emacs-directory "etc/make-it-so")))
    (define-key dired-mode-map (kbd ", ,") 'make-it-so)))

(use-package dired-rainbow
  :ensure t
  :config
  ;; executable files
  (dired-rainbow-define-chmod executable-unix "Green" "-[rw-]+x.*"))

(use-package dired-subtree
  :ensure t
  :config
  (define-key dired-mode-map (kbd ", s o") 'dired-subtree-insert)
  (define-key dired-mode-map (kbd ", s c") 'dired-subtree-remove))

(use-package dired-collapse
  :ensure t
  :config
  (define-key dired-mode-map (kbd ", c") 'dired-collapse-mode))

;; Weather ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package wttrin
  :ensure t
  :config
  (setq wttrin-default-cities '("Wilmington, NC" "Raleigh, NC" "Springfield, VA" "Tokyo")
        wttrin-default-accept-language '("Accept-Language" . "en-US")))

;; Alerts ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package alert
  :ensure t
  :config
  (setq alert-default-style (if (equal system-type 'gnu/linux) 'notifications 'message)))

;; Junk buffers ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Open a quicky file to make quick notes in; by default under ~/.junk/
(use-package open-junk-file
  :ensure t
  :init (require 'open-junk-file)
  :config
  (setq open-junk-file-directory "~/.junk/%Y/%m/%d-%H%M%S.")
  (define-key jws/leader-map (kbd "f j") 'open-junk-file))

;; Assorted other stuff ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; I'm one of THOSE PEOPLE who use emoticons semi-regularly, but usually I prefer
;; more text-based emotes.  Emoji have a real handy use though; a good graphical
;; way to represent countries/nationalities.  Sticking a flag like 🇫🇷 in an org-mode
;; file is a nice graphical way to represent the concept of "France."
(use-package emojify
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-emojify-mode)
  (define-key jws/leader-map (kbd "u j") 'emojify-insert-emoji))

(after 'counsel
  ;; "character map"
  (define-key jws/leader-map (kbd "u u") 'counsel-unicode-char)

  ;; Colors
  (define-key jws/leader-map (kbd "u o") 'counsel-colors-web)

  ;; Clipboard manager
  (define-key jws/leader-map (kbd "u k") 'counsel-yank-pop))

;; Taken from http://emacsredux.com/blog/2013/03/27/copy-filename-to-the-clipboard/
(defun jws/copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(define-key jws/leader-map (kbd "b c") 'jws/copy-file-name-to-clipboard)

(provide 'jws-utils)
