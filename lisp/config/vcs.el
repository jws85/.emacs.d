(use-package magit
  :ensure t
  :config
  (progn
    (setq magit-last-seen-setup-instructions "1.4.0")
    
    (after 'evil
      ;; Yes, this is necessary to get Vim keybindings in Magit for the moment
      ;; See @uu1101's post in https://github.com/magit/magit/issues/1968
      (dolist (map (list
                    ;; Mode maps
                    magit-blame-mode-map
                    magit-cherry-mode-map
                    magit-diff-mode-map
                    magit-log-mode-map
                    magit-log-select-mode-map
                    magit-mode-map
                    ;; No evil keys for the popup.
                    ;; magit-popup-help-mode-map
                    ;; magit-popup-mode-map
                    ;; magit-popup-sequence-mode-map
                    magit-process-mode-map
                    magit-reflog-mode-map
                    magit-refs-mode-map
                    magit-revision-mode-map
                    magit-stash-mode-map
                    magit-stashes-mode-map
                    magit-status-mode-map
                    ;; Section submaps
                    magit-branch-section-map
                    magit-commit-section-map
                    magit-file-section-map
                    magit-hunk-section-map
                    magit-module-commit-section-map
                    magit-remote-section-map
                    magit-staged-section-map
                    magit-stash-section-map
                    magit-stashes-section-map
                    magit-tag-section-map
                    magit-unpulled-section-map
                    magit-unpushed-section-map
                    magit-unstaged-section-map
                    magit-untracked-section-map))
        ;; Move current bindings for movement keys to their upper-case counterparts.
        (dolist (key (list "k" "j" "h" "l"))
          (let ((binding (lookup-key map key)))
            (when binding
              (define-key map (upcase key) binding) (define-key map key nil))))
        (evil-add-hjkl-bindings map 'emacs
          (kbd "v") 'evil-visual-char
          (kbd "V") 'evil-visual-line
          (kbd "C-v") 'evil-visual-block
          (kbd "C-w") 'evil-window-map))
      (dolist (mode (list 'magit-blame-mode
                          'magit-cherry-mode
                          'magit-diff-mode
                          'magit-log-mode
                          'magit-log-select-mode
                          'magit-mode
                          'magit-popup-help-mode
                          'magit-popup-mode
                          'magit-popup-sequence-mode
                          'magit-process-mode
                          'magit-reflog-mode
                          'magit-refs-mode
                          'magit-revision-mode
                          'magit-stash-mode
                          'magit-stashes-mode
                          'magit-status-mode))
        (add-to-list 'evil-emacs-state-modes mode))
      ;; end vim keybinding massive hack

      (define-key evil-normal-state-map (kbd ", g") 'magit-status))))

(provide 'config/vcs)
