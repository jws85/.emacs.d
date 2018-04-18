;; Shells ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Disable company-mode in shell, to prevent needing to hit RET twice
(defun jws/disable-completion-in-shell ()
  (company-mode -1)
  (setq-local company-mode nil))
(add-hook 'shell-mode-hook #'jws/disable-completion-in-shell)

;; Disable evil in term modes
(evil-set-initial-state 'term-mode 'emacs)

;; Close the ansi-term buffer when finished
(defun jws/oleh-term-exec-hook ()
  "Copied from https://oremacs.com/2015/01/01/three-ansi-term-tips/"
  (let* ((buff (current-buffer))
         (proc (get-buffer-process buff)))
    (set-process-sentinel
     proc
     `(lambda (process event)
        (if (string= event "finished\n")
            (kill-buffer ,buff))))))
(add-hook 'term-exec-hook 'jws/oleh-term-exec-hook)

;; Open up shell through shortcut
(defun jws/ansi-term-zsh ()
  (interactive)
  (ansi-term "/bin/zsh"))

(define-key jws/leader-map (kbd "u s") 'jws/ansi-term-zsh)

;; Image viewing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Turn off evil-mode when viewing images
(require 'image-mode)
(evil-set-initial-state 'image-mode 'emacs)


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

;; Assorted other stuff ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

(provide 'jws-utils)
