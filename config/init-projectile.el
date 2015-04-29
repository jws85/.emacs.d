(use-package projectile
  :ensure t
  :init (projectile-global-mode)
  :config
  (progn
    (after 'evil
      (define-key evil-normal-state-map (kbd ", p r") 'projectile-regenerate-tags)
      (define-key evil-normal-state-map (kbd ", p p") 'projectile-find-file)
      (define-key evil-normal-state-map (kbd ", p s") 'projectile-switch-project)
      (define-key evil-normal-state-map (kbd ", p g") 'projectile-grep)
      (define-key evil-normal-state-map (kbd ", p c") 'projectile-compile-project))

    (setq projectile-enable-caching t)))

; FIXME -- currently these are broken!  If I let projectile vomit into my
; .emacs.d the cache files are persistent across emacs restarts.  If I put
; it in the cache directory, it will not work right.
;(setq projectile-cache-file (concat user-emacs-directory ".cache/projectile.cache"))
;(setq projectile-known-projects-file (concat user-emacs-directory ".cache/projectile-bookmarks.eld"))

(provide 'init-projectile)
