;; Quit recursive edit; used to make the Escape key work like in Vim
; from https://github.com/davvil/.emacs.d/blob/master/init.el
(defun jws/minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

;; Switches to the previous buffer without prompting or anything.
;; I've always mapped this to <leader>j -- Vim also puts this on
;; C-6 but I stopped using that binding a while before I even took
;; emacs back up.
(defun jws/switch-to-previous-buffer ()
  "Switches to the previous buffer."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer))))

(use-package evil
  :ensure t
  :init (setq evil-want-keybinding nil)
  :config
  (evil-mode t)

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

  ;; Make escape work like in vim
  (define-key evil-normal-state-map [escape] 'keyboard-quit)
  (define-key evil-visual-state-map [escape] 'keyboard-quit)
  (define-key minibuffer-local-map [escape] 'jws/minibuffer-keyboard-quit)
  (define-key minibuffer-local-ns-map [escape] 'jws/minibuffer-keyboard-quit)
  (define-key minibuffer-local-completion-map [escape] 'jws/minibuffer-keyboard-quit)
  (define-key minibuffer-local-must-match-map [escape] 'jws/minibuffer-keyboard-quit)
  (define-key minibuffer-local-isearch-map [escape] 'jws/minibuffer-keyboard-quit)

  (define-key evil-normal-state-map (kbd "[ SPC") (bind (evil-insert-newline-above) (forward-line)))
  (define-key evil-normal-state-map (kbd "] SPC") (bind (evil-insert-newline-below) (forward-line -1)))
  (define-key evil-normal-state-map (kbd "[ e") (kbd "ddkP"))
  (define-key evil-normal-state-map (kbd "] e") (kbd "ddp"))
  (define-key evil-normal-state-map (kbd "[ b") 'previous-buffer)
  (define-key evil-normal-state-map (kbd "] b") 'next-buffer)
  (define-key evil-normal-state-map (kbd "[ q") 'previous-error)
  (define-key evil-normal-state-map (kbd "] q") 'next-error)

  (setq evil-default-cursor t
        lazy-highlight-cleanup nil
        lazy-highlight-max-at-a-time nil
        lazy-highlight-initial-delay 0))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (setq evil-collection-mode-list '(dired eshell eww ibuffer image image+))
  (evil-collection-init))

(use-package evil-string-inflection
  :after evil
  :ensure t)

(define-key jws/leader-map (kbd "<tab>") 'jws/switch-to-previous-buffer)
(define-key jws/leader-map (kbd "k") 'kill-this-buffer)

(provide 'jws-vi)
