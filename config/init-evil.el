(use-package evil
  :init (evil-mode t)
  :ensure t

  :config
  (progn
    ;; evil requires undo-tree
    (after 'diminish
      (diminish 'undo-tree-mode))

    ;; artist-mode is allergic to evil
    (after 'evil
      (add-hook 'artist-mode-hook 'evil-emacs-state))

    ;; Emulates surround.vim plugin (https://github.com/tpope/vim-surround)
    (use-package evil-surround
      :ensure t
      :init (global-evil-surround-mode 1))

    ;; when deleting a tab, delete the tab, do NOT turn it into spaces
    (define-key evil-insert-state-map (kbd "<backspace>") 'backward-delete-char)

    (require 'jws/keybinding-helpers)

    ;; Make escape work like in vim
    (define-key evil-normal-state-map [escape] 'keyboard-quit)
    (define-key evil-visual-state-map [escape] 'keyboard-quit)
    (define-key minibuffer-local-map [escape] 'jws/minibuffer-keyboard-quit)
    (define-key minibuffer-local-ns-map [escape] 'jws/minibuffer-keyboard-quit)
    (define-key minibuffer-local-completion-map [escape] 'jws/minibuffer-keyboard-quit)
    (define-key minibuffer-local-must-match-map [escape] 'jws/minibuffer-keyboard-quit)
    (define-key minibuffer-local-isearch-map [escape] 'jws/minibuffer-keyboard-quit)

    (define-key evil-normal-state-map (kbd ", j") 'jws/switch-to-previous-buffer)

    (define-key evil-normal-state-map (kbd ", e") 'eval-region)

    (define-key evil-normal-state-map (kbd "[ SPC") (bind (evil-insert-newline-above) (forward-line)))
    (define-key evil-normal-state-map (kbd "] SPC") (bind (evil-insert-newline-below) (forward-line -1)))
    (define-key evil-normal-state-map (kbd "[ e") (kbd "ddkP"))
    (define-key evil-normal-state-map (kbd "] e") (kbd "ddp"))
    (define-key evil-normal-state-map (kbd "[ b") 'previous-buffer)
    (define-key evil-normal-state-map (kbd "] b") 'next-buffer)
    (define-key evil-normal-state-map (kbd "[ q") 'previous-error)
    (define-key evil-normal-state-map (kbd "] q") 'next-error)

    (define-key evil-normal-state-map (kbd ", k") 'kill-this-buffer)

    (define-key evil-normal-state-map (kbd ", d m") 'woman)

    (setq evil-default-cursor t
	  lazy-highlight-cleanup nil
	  lazy-highlight-max-at-a-time nil
	  lazy-highlight-initial-delay 0)))

(provide 'init-evil)
