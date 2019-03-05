;; Image viewing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package image
  :commands image-mode)

(use-package image+
  :ensure t
  :after image
  :config
  (eval-after-load 'image '(require 'image+)))

;; Dired ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package dired
  :commands dired

  :preface
  (defun jws/dired-curdir ()
    (interactive)
    (let* ((parent (if (buffer-file-name)
                       (file-name-directory (buffer-file-name))
                      default-directory))
           (name (car (last (split-string parent "/" t)))))
      (dired parent)
      (rename-buffer (concat "*dired: " name "*"))))

  (defun jws/dired-home ()
    (interactive)
    (dired "~"))

  :init
  (define-key jws/leader-map (kbd "d d") 'jws/dired-curdir)
  (define-key jws/leader-map (kbd "d h") 'jws/dired-home))

(use-package dired-x
  :config
  ;; Show/hide hidden files
  (setq dired-omit-files "^\\...+$")
  (add-hook 'dired-mode-hook (lambda () (dired-omit-mode 1)))
  (define-key dired-mode-map (kbd "C-c h") 'dired-omit-mode))

;; make-it-so, a package to perform batch file conversions with dired
(use-package make-it-so
  :ensure t
  :after dired
  :config
  (progn
    (setq mis-recipes-directory (expand-file-name (concat user-emacs-directory "etc/make-it-so")))
    (define-key dired-mode-map (kbd "C-c m") 'make-it-so)))

(use-package dired-rainbow
  :ensure t
  :after dired
  :config
  ;; executable files
  (dired-rainbow-define-chmod executable-unix "Green" "-[rw-]+x.*"))

(use-package dired-subtree
  :ensure t
  :after dired
  :config
  (define-key dired-mode-map (kbd "C-c s a") 'dired-subtree-insert)
  (define-key dired-mode-map (kbd "C-c s d") 'dired-subtree-remove))

(use-package dired-collapse
  :ensure t
  :after dired
  :config
  (define-key dired-mode-map (kbd "C-c c") 'dired-collapse-mode))

;; Weather ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package wttrin
  :ensure t
  :commands wttrin
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
  :commands open-junk-file
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
  (setq emojify-download-emojis-p nil)
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
