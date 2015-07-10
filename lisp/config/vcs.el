(use-package magit
  :ensure t
  :config
  (progn
    (setq magit-last-seen-setup-instructions "1.4.0")
    
    (after 'evil
      ;; FIXME these binds don't work, just use C-n/C-p for now
      ;(evil-add-hjkl-bindings magit-status-mode-map 'emacs
      ;  "l" 'magit-key-mode-popup-logging
      ;  "v" 'set-mark-command)
      ;(evil-add-hjkl-bindings magit-log-mode-map 'emacs)
      ;(evil-add-hjkl-bindings magit-commit-mode-map 'emacs)
      ;(evil-add-hjkl-bindings magit-diff-mode-map 'emacs)

      (define-key evil-normal-state-map (kbd ", g") 'magit-status))))

(provide 'config/vcs)
