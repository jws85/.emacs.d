;; Lossage in switch to ivy:
;;  ,eo -- #'helm-occur, which is basically swiper
;;  ,ef -- #'helm-semantic-or-imenu
;;  ,er -- #'helm-regexp

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
    (use-package counsel-dash :ensure t :init (require 'counsel-dash))

    (require 'counsel-surfraw)

    (setq ivy-use-virtual-buffers t
          ivy-count-format "(%d/%d)"
          ivy-magic-tilde nil
          counsel-find-file-at-point t)

    ;; I don't want org-refile to have its initial input, due to settings I'm
    ;; using with it now...
    (setq ivy-initial-inputs-alist
          (assq-delete-all 'org-capture-refile
                           (assq-delete-all 'org-agenda-refile
                                            (assq-delete-all 'org-refile ivy-initial-inputs-alist))))

    ;; Fix shortest match irritation with counsel-find-files
    ;; https://github.com/abo-abo/swiper/issues/723
    (defun jws/ivy-sort-files-function (_name candidates)
      "Sort CANDIDATES files alphabetically ignoring trailing slashes.
Meant for use in `ivy-sort-matches-functions-alist' so
directories will have a trailing /, ignore it so foo.txt is after foo/."
      ;; Perhaps add a check for if directories should sort first
      (cl-sort (copy-sequence candidates)
               (lambda (x y)
                 (string< (if (string-suffix-p "/" x) (substring x 0 -1) x)
                          (if (string-suffix-p "/" y) (substring y 0 -1) y)))))

    ;; Actually use jws/ivy-sort-files-function
    (setq ivy-sort-matches-functions-alist
          '((t)
            (ivy-switch-buffer . ivy-sort-function-buffer)
            (counsel-find-file . jws/ivy-sort-files-function)))

    (define-key ivy-mode-map (kbd "C-SPC") 'ivy-restrict-to-matches)

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
    (define-key evil-normal-state-map (kbd "SPC SPC") 'counsel-M-x)
    (define-key evil-visual-state-map (kbd "SPC SPC") 'counsel-M-x)
    (define-key evil-normal-state-map (kbd "SPC f") 'counsel-find-file)
    (define-key evil-normal-state-map (kbd "SPC b") 'ivy-switch-buffer)
    (global-set-key (kbd "M-j f") 'counsel-find-file)
    (global-set-key (kbd "M-j b") 'ivy-switch-buffer)

    (defhydra jws/hydra-ivy (:exit t)
      ("u" counsel-unicode-char "Find character")
      ("l" counsel-locate "Locate file")
      ("g" counsel-ag "Find string in folder")
      ("c" counsel-colors-web "Find color")
      ("k" counsel-yank-pop "Find yank")
      ("m" woman "Find manpage")
      ("d" counsel-dash "Find docset")
      ("w" counsel-surfraw "Find webpage"))

    (global-set-key (kbd "M-j e") 'jws/hydra-ivy/body)
    (jws/after (evil)
      (define-key evil-normal-state-map (kbd "SPC e") 'jws/hydra-ivy/body))))

(provide 'jws-searching)
