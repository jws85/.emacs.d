;; Lossage in switch to ivy:
;;  ,eo -- #'helm-occur, which is basically swiper
;;  ,ek -- #'helm-show-kill-ring
;;  ,ef -- #'helm-semantic-or-imenu
;;  ,er -- #'helm-regexp
;;  ,ec -- #'helm-colors
;;  ,ew -- #'helm-surfraw

(use-package ivy
  :ensure t
  :init
  (progn
    (require 'ivy)
    (ivy-mode 1))
  :config
  (progn
    (use-package ivy-hydra :ensure t :init (require 'ivy-hydra))
    (use-package counsel :ensure t :init (require 'counsel))
    (use-package swiper :ensure t :init (require 'swiper))

    (setq ivy-use-virtual-buffers t
          ivy-count-format "(%d/%d)")

    (global-set-key (kbd "C-s") 'swiper)

    (after 'projectile
      (setq projectile-completion-system 'ivy))

    (after 'magit
      (setq magit-completing-read-function 'ivy-completing-read))

    (after 'evil
      (define-key evil-normal-state-map (kbd "/") 'swiper)
      (define-key evil-normal-state-map (kbd ";") 'counsel-M-x)
      (define-key evil-normal-state-map (kbd ":") 'counsel-M-x)
      (define-key evil-normal-state-map (kbd ", f") 'counsel-find-file)
      (define-key evil-normal-state-map (kbd ", b") 'ivy-switch-buffer)
      (define-key evil-normal-state-map (kbd ", e u") 'counsel-unicode-char)
      (define-key evil-normal-state-map (kbd ", e l") 'counsel-locate)
      (define-key evil-normal-state-map (kbd ", e g") 'counsel-ag)
      (define-key evil-normal-state-map (kbd ", e m") 'woman))))

(provide 'jws-searching)
