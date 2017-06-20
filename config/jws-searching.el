;; Lossage in switch to ivy:
;;  ,eo -- #'helm-occur, which is basically swiper
;;  ,ek -- #'helm-show-kill-ring
;;  ,ef -- #'helm-semantic-or-imenu
;;  ,er -- #'helm-regexp
;;  ,ew -- #'helm-surfraw

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

    (after 'projectile
      (use-package counsel-projectile :ensure t
        :init (require 'counsel-projectile)
        :config (counsel-projectile-on)))

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

    (after 'evil
      (after 'projectile
        (define-key evil-normal-state-map (kbd ", p g") 'counsel-projectile-ag)
        ;; If projectile is active in a buffer, use the projectile project as the
        ;; ag bounds; otherwise just ag in the file's directory
        (defun jws/counsel-ag-contextual ()
          (interactive)
          (if (projectile-project-p)
              (counsel-projectile-ag)
            (counsel-ag)))
        (define-key evil-normal-state-map (kbd ", e g") 'jws/counsel-ag-contextual))

      (define-key evil-normal-state-map (kbd "/") 'counsel-grep-or-swiper)
      (define-key evil-normal-state-map (kbd ";") 'counsel-M-x)
      (define-key evil-normal-state-map (kbd ":") 'counsel-M-x)
      (define-key evil-normal-state-map (kbd ", f") 'counsel-find-file)
      (define-key evil-normal-state-map (kbd ", b") 'ivy-switch-buffer)
      (define-key evil-normal-state-map (kbd ", e u") 'counsel-unicode-char)
      (define-key evil-normal-state-map (kbd ", e l") 'counsel-locate)
      (define-key evil-normal-state-map (kbd ", e c") 'counsel-colors-web)
      (define-key evil-normal-state-map (kbd ", e m") 'woman))))

(provide 'jws-searching)
