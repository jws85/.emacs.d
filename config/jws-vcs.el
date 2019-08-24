(use-package magit
  :ensure t
  :defer t
  :init
  (define-key jws/leader-map (kbd "g g") 'magit-status)
  (define-key jws/leader-map (kbd "g b") 'magit-branch-checkout)
  (define-key jws/leader-map (kbd "g B") 'magit-blame)
  (define-key jws/leader-map (kbd "g i") 'magit-init)
  (define-key jws/leader-map (kbd "g l") 'magit-log-all-branches)
  :config
  (setq magit-last-seen-setup-instructions "1.4.0")

  ;; ganked from https://stackoverflow.com/a/9440260
  (defun jws/magit-status-full-frame ()
    "Don't split window."
    (interactive)
    (let ((pop-up-windows nil))
      (call-interactively 'magit-status))))

(use-package magit-gitflow
  :ensure t
  :after magit
  :config
  (require 'magit-gitflow)
  (add-hook 'magit-mode-hook 'turn-on-magit-gitflow)
  (define-key magit-mode-map "%" 'magit-gitflow-popup))

(use-package evil-magit
  :ensure t
  :after (evil magit)
  :config
  (require 'evil-magit))

(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode t))

(use-package git-timemachine
  :ensure t
  :defer t
  :init
  (define-key jws/leader-map (kbd "g t") 'git-timemachine))

(provide 'jws-vcs)
