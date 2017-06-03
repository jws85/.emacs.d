(require 'ido)

;; enables ido-mode in as many places as possible...
(ido-mode t)
(ido-everywhere t)

;; including everywhere where there's completing-read
(use-package ido-ubiquitous
  :ensure t
  :init (ido-ubiquitous-mode 1))

(use-package ido-vertical-mode
  :ensure t
  :init
  (progn
    (ido-vertical-mode 1)
    (setq ido-vertical-define-keys 'C-n-and-C-p-only)))

;; ido is super-automated.  This is awesome in a lot of ways, but it often
;; gets in the way of me actually doing work, e.g. creating new files.

;; disable searching in unrelated directories; e.g. I'm in ~/a/b/c and
;; decide to make a new file ~/a/b/c/foobar, but I was recently in ~/z
;; which has ~/z/foobar; ido will present me with ~/z/foobar which is
;; often infuriating
(setq ido-auto-merge-work-directories-length -1)

;; require pressing enter to confirm the current directory
(setq ido-confirm-unique-completion nil)
(setq ido-enable-tramp-completion nil)

;; map find-file and switch-buffer to easier keys
(after 'evil
  (define-key evil-normal-state-map (kbd ", f") 'ido-find-file)
  (define-key evil-normal-state-map (kbd ", b") 'ido-switch-buffer))

(defun jws/ido-hook ()
  (define-key ido-completion-map (kbd "<down>") 'ido-next-match)
  (define-key ido-completion-map (kbd "<up>") 'ido-prev-match))

(add-hook 'ido-setup-hook 'jws/ido-hook)

;; enables a 'nicer' matching method (warning: possible performance killer,
;; but on this old AMD here, and my i5-3570k back home, it works fine)
(use-package flx-ido
  :ensure t
  :init (flx-ido-mode t))

;; ido niceties in the M-x command interface
(use-package smex
  :ensure t
  :init (smex-initialize)
  :config
  (progn
    (global-set-key (kbd "M-x") 'smex)
    (after 'evil
      (define-key evil-normal-state-map (kbd ";") 'smex)
      (define-key evil-visual-state-map (kbd ";") 'smex))))

;; I don't like helm-find-files, but I find a lot of the helm commands
;; to be otherwise nifty.  This is why I just do helm-config and don't
;; run the full helm-mode.
(use-package helm
  :ensure t
  :init (require 'helm-config)
  :config
  (progn
    (after 'evil
      ; searchable character map
      (define-key evil-normal-state-map (kbd ", e u") 'helm-ucs)

      ; find string in buffer
      (define-key evil-normal-state-map (kbd ", e o") 'helm-occur)

      ; show clipboard
      (define-key evil-normal-state-map (kbd ", e k") 'helm-show-kill-ring)

      ; find function definitions
      (define-key evil-normal-state-map (kbd ", e f") 'helm-semantic-or-imenu)

      ; run an elisp regex against the buffer
      (define-key evil-normal-state-map (kbd ", e r") 'helm-regexp)

      ; find a file using 'locate' binary (uses 'everything' on Windows)
      (define-key evil-normal-state-map (kbd ", e l") 'helm-locate)

      ; searchable list of colors
      (define-key evil-normal-state-map (kbd ", e c") 'helm-colors)

      ; uses 'surfraw' to look up things online
      (define-key evil-normal-state-map (kbd ", e w") 'helm-surfraw)

      ; look up man pages
      (define-key evil-normal-state-map (kbd ", e m") 'helm-man-woman))

    ; use "The Silver Searcher" (ag) binary to find files in project
    (use-package helm-ag
      :ensure t
      :config
      (after 'evil
        (define-key evil-normal-state-map (kbd ", e g") 'helm-ag)))))

(provide 'jws-searching)
