(use-package projectile
  :ensure t
  ;:init (projectile-global-mode) ;; disabling always-on mode, see below comment
  :config
  (progn
    (after 'evil
      (define-key evil-normal-state-map (kbd "C-p") 'projectile-find-file))

    (setq projectile-enable-caching t)

    ;; I use a lot of sshfs, and I have noticed horrendous performance when
    ;; trying to load certain files over sshfs that was resolved by disabling
    ;; projectile.
    ;;
    ;; The below is some code from 'barrkel' in the comments on this issue:
    ;; https://github.com/bbatsov/projectile/issues/657
    ;; It wraps a particularly slow function in projectile with some advice
    ;; to memoize (cache) the function.  It also disables projectile unless
    ;; the file is within a git repo.  For me, git is the only VCS I use, so
    ;; I am fine with this limitation.
    (add-hook 'find-file-hook
              (lambda ()
                (if (locate-dominating-file default-directory ".git")
                    (projectile-mode))))
    (eval-after-load "projectile"
      '(progn
         (defvar-local bk/projectile-project-name-cache nil
           "Cached value of projectile-project-name")

         (defadvice projectile-project-name (around bk/projectile-project-name activate)
           (if (not bk/projectile-project-name-cache)
               (setq bk/projectile-project-name-cache ad-do-it))
           (setq ad-return-value bk/projectile-project-name-cache))))
    ))

; FIXME -- currently these are broken!  If I let projectile vomit into my
; .emacs.d the cache files are persistent across emacs restarts.  If I put
; it in the cache directory, it will not work right.
;(setq projectile-cache-file (concat user-emacs-directory ".cache/projectile.cache"))
;(setq projectile-known-projects-file (concat user-emacs-directory ".cache/projectile-bookmarks.eld"))

(use-package counsel-projectile
  :ensure t
  :after projectile
  :init (require 'counsel-projectile)
  :config (counsel-projectile-on))

(jws/after (counsel counsel-projectile hydra)
  (defhydra jws/hydra-project (:exit t)
    ("p" projectile-find-file "Find file in project")
    ("s" projectile-switch-project "Switch project")
    ("g" counsel-projectile-ag "Find string in project")
    ("c" projectile-compile-project "Compile project")
    ("r" projectile-regenerate-tags "Reload tags" :exit nil))

  (global-set-key (kbd "C-c C-c p") 'jws/hydra-project/body)
  (jws/after (evil)
    (define-key evil-normal-state-map (kbd ", p") 'jws/hydra-project/body)))

(provide 'jws-project)
