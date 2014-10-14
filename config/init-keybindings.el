(after 'smex
  (global-set-key (kbd "M-x") 'smex))

(after 'expand-region
  (global-set-key (kbd "C-=") 'er/expand-region))

(after 'evil
  ;; a lot of these are 'stolen' from bling's dotemacs at https://github.com/bling/dotemacs

  ;; I'm trying out a keybinding scheme as follows:
  ;;  - [ <key> and ] <key> are mapped to complementary functions (e.g. unimpaired.vim)
  ;;  - , <key> is mapped to everything else
  ;; Note that all multi-key chords that share a common substring must be the same length, e.g.
  ;; you can't bind ,p and ,pg at the same time, you'll need to make ,p longer

  ;; when deleting a tab, delete the tab, do NOT turn it into spaces
  (define-key evil-insert-state-map (kbd "<backspace>") 'backward-delete-char)

  ;; Make escape work like in vim
  (define-key evil-normal-state-map [escape] 'keyboard-quit)
  (define-key evil-visual-state-map [escape] 'keyboard-quit)
  (define-key minibuffer-local-map [escape] 'jws/minibuffer-keyboard-quit)
  (define-key minibuffer-local-ns-map [escape] 'jws/minibuffer-keyboard-quit)
  (define-key minibuffer-local-completion-map [escape] 'jws/minibuffer-keyboard-quit)
  (define-key minibuffer-local-must-match-map [escape] 'jws/minibuffer-keyboard-quit)
  (define-key minibuffer-local-isearch-map [escape] 'jws/minibuffer-keyboard-quit)

  (define-key evil-normal-state-map (kbd ", j") 'jws/switch-to-previous-buffer)
  (define-key evil-normal-state-map (kbd ", h") 'jws/describe-at-point)

  (define-key evil-normal-state-map (kbd ", e") 'eval-region)

  ;; keys to switch modes
  (define-key evil-normal-state-map (kbd ", m w") 'web-mode)
  (define-key evil-normal-state-map (kbd ", m p") 'php-mode)
  (define-key evil-normal-state-map (kbd ", m j") 'js2-mode)
  (define-key evil-normal-state-map (kbd ", m c") 'css-mode)

  (define-key evil-normal-state-map (kbd "[ SPC") (bind (evil-insert-newline-above) (forward-line)))
  (define-key evil-normal-state-map (kbd "] SPC") (bind (evil-insert-newline-below) (forward-line -1)))
  (define-key evil-normal-state-map (kbd "[ e") (kbd "ddkP"))
  (define-key evil-normal-state-map (kbd "] e") (kbd "ddp"))
  (define-key evil-normal-state-map (kbd "[ b") 'previous-buffer)
  (define-key evil-normal-state-map (kbd "] b") 'next-buffer)
  (define-key evil-normal-state-map (kbd "[ q") 'previous-error)
  (define-key evil-normal-state-map (kbd "] q") 'next-error)

  (define-key evil-normal-state-map (kbd ", k") 'kill-this-buffer)

  (after 'ido
    (define-key evil-normal-state-map (kbd ", f") 'ido-find-file)
    (define-key evil-normal-state-map (kbd ", b") 'ido-switch-buffer))

;  (after 'helm
;    (define-key evil-normal-state-map (kbd "SPC f") 'helm-find-files)
;    (define-key evil-normal-state-map (kbd "SPC b") 'helm-mini))

  ;; visual mapping as well because sometimes you'd like to operate on a region
  ;; e.g. eval-region to evaluate some elisp sexps
  (after 'smex
    (define-key evil-normal-state-map ";" 'smex)
    (define-key evil-visual-state-map ";" 'smex))

  ;; SPC to pick letter and jump to word beginning with letter
  ;; C-u SPC to pick a letter and jump to it
  ;; C-u C-u SPC to jump to a line
  (after 'ace-jump-mode
    (define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode))

  (after 'projectile
    (define-key evil-normal-state-map (kbd ", p") 'projectile-find-file)
    (define-key evil-normal-state-map (kbd ", g") 'projectile-ag)
    (define-key evil-normal-state-map (kbd ", t") 'projectile-regenerate-tags)))

(provide 'init-keybindings)
