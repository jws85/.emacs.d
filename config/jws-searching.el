;; Lossage in switch to ivy:
;;  ,eo -- #'helm-occur, which is basically swiper
;;  ,ef -- #'helm-semantic-or-imenu
;;  ,er -- #'helm-regexp

(require 'counsel-surfraw)

(use-package ivy
  :ensure t
  :init
  (progn
    (require 'ivy)
    (ivy-mode 1))
  :config
  (progn
    (after 'diminish
      (diminish 'ivy-mode))

    (use-package ivy-hydra :ensure t :init (require 'ivy-hydra))
    (use-package counsel :ensure t :init (require 'counsel))
    (use-package swiper :ensure t :init (require 'swiper))
    (use-package flx :ensure t :init (require 'flx))
    (use-package smex :ensure t :init (require 'smex))

    (setq ivy-use-virtual-buffers t
          ivy-count-format "(%d/%d)"
          ivy-magic-tilde nil
          counsel-find-file-at-point t)

    ;; I'm not sure of the implication of this... but it fixes an irritating
    ;; impedance mismatch between helm/ivy and ido.  When you use RET in
    ;; ido-find-files on a dir, it does ido on the dir.  When you use RET in
    ;; ivy/helm, it fires up dired, killing my flow like nothing else.
    ;; This fixes that!
    (define-key ivy-minibuffer-map (kbd "<return>") 'ivy-alt-done)

    (global-set-key (kbd "C-s") 'counsel-grep-or-swiper)

    (after 'projectile
      (setq projectile-completion-system 'ivy))

    (after 'magit
      (setq magit-completing-read-function 'ivy-completing-read))

    (define-key evil-normal-state-map (kbd "/") 'counsel-grep-or-swiper)
    (define-key evil-normal-state-map (kbd ";") 'counsel-M-x)
    (define-key evil-visual-state-map (kbd ";") 'counsel-M-x)
    (define-key evil-normal-state-map (kbd ", f") 'counsel-find-file)
    (define-key evil-normal-state-map (kbd ", b") 'ivy-switch-buffer)
    (global-set-key (kbd "M-j f") 'counsel-find-file)
    (global-set-key (kbd "M-j b") 'ivy-switch-buffer)

    (defhydra jws/hydra-ivy (:exit t)
      ("u" counsel-unicode-char "Find character")
      ("l" counsel-locate "Locate file")
      ("g" counsel-ag "Find string in folder")
      ("c" counsel-colors-web "Find color")
      ("k" counsel-yank-pop "Find yank")
      ("m" woman "Find manpage")
      ("w" counsel-surfraw "Find webpage"))

    (global-set-key (kbd "M-j e") 'jws/hydra-ivy/body)
    (jws/after (evil)
      (define-key evil-normal-state-map (kbd ", e") 'jws/hydra-ivy/body))))

(provide 'jws-searching)
