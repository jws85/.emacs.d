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

(global-set-key (kbd "M-j s") 'jws/ansi-term-zsh)
(after 'evil (define-key evil-normal-state-map (kbd "SPC s") 'jws/ansi-term-zsh))

;; Image viewing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Turn off evil-mode when viewing images
(require 'image-mode)
(evil-set-initial-state 'image-mode 'emacs)

;; Dired ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun jws/dired-home ()
  (interactive)
  (dired "~"))

(global-set-key (kbd "M-j u d") 'jws/dired-home)
(after 'evil (define-key evil-normal-state-map (kbd "SPC u d") 'jws/dired-home))

;; make-it-so, a package to perform batch file conversions with dired
(use-package make-it-so
  :ensure t
  :init (require 'make-it-so)
  :config
  (progn
    (setq mis-recipes-directory (expand-file-name (concat user-emacs-directory "etc/make-it-so")))
    (define-key dired-mode-map (kbd ", ,") 'make-it-so)))

;; Weather ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package wttrin
  :ensure t
  :config
  (setq wttrin-default-cities '("Wilmington, NC" "Raleigh, NC" "Springfield, VA" "Tokyo")
        wttrin-default-accept-language '("Accept-Language" . "en-US")))

(provide 'jws-utils)
