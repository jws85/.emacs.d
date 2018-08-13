(use-package projectile
  :ensure t
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
           (setq ad-return-value bk/projectile-project-name-cache))))))


; FIXME -- currently these are broken!  If I let projectile vomit into my
; .emacs.d the cache files are persistent across emacs restarts.  If I put
; it in the cache directory, it will not work right.
;(setq projectile-cache-file (concat user-emacs-directory ".cache/projectile.cache"))
;(setq projectile-known-projects-file (concat user-emacs-directory ".cache/projectile-bookmarks.eld"))

(use-package counsel-projectile
  :ensure t
  :preface (setq projectile-keymap-prefix (kbd "C-c p")) ; [FIXME] Quick hack q.v. https://github.com/ericdanan/counsel-projectile/pull/92
  :after projectile
  :config (counsel-projectile-mode))

;; Needed by the code figuring out the grep command du jour...
(defun jws/not-nil-p (val)
  (not (eq val nil)))

(jws/after (counsel counsel-projectile hydra)
  ;; If rg isn't installed, go with ag
  ;; if ag isn't installed, fall back to grep
  ;; rg requires a full Rust toolchain on Debian boxen, or SSSE2 support for the binary
  ;; ag is at least available as a package on *buntu (silversearcher-ag)
  (setq jws/project-grep-command
        (cond
         ((jws/not-nil-p (executable-find "rg")) #'counsel-projectile-rg)
         ((jws/not-nil-p (executable-find "ag")) #'counsel-projectile-ag)
         (t #'counsel-projectile-grep)))

  (defhydra jws/hydra-project (:exit t)
    ("p" projectile-find-file "Find file in project")
    ("s" projectile-switch-project "Switch project")
    ("g" (funcall jws/project-grep-command) "Find string in project")
    ("c" projectile-compile-project "Compile project")
    ("r" projectile-regenerate-tags "Reload tags" :exit nil))

  (define-key jws/leader-map (kbd "p") 'jws/hydra-project/body))

(provide 'jws-project)
