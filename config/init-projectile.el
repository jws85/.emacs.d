(use-package projectile
  :ensure t
  :init (projectile-global-mode)
  :config
  (progn
    (after 'evil
      (define-key evil-normal-state-map (kbd ", p") 'projectile-find-file)
      (define-key evil-normal-state-map (kbd ", a") 'projectile-ag)
      (define-key evil-normal-state-map (kbd ", t") 'projectile-regenerate-tags))
    (setq projectile-enable-caching t)))

; FIXME -- currently these are broken!  If I let projectile vomit into my
; .emacs.d the cache files are persistent across emacs restarts.  If I put
; it in the cache directory, it will not work right.
;(setq projectile-cache-file (concat user-emacs-directory ".cache/projectile.cache"))
;(setq projectile-known-projects-file (concat user-emacs-directory ".cache/projectile-bookmarks.eld"))

(provide 'init-projectile)
