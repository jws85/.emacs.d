(require 'evil)
(evil-mode t)
(setq evil-default-cursor t)

(setq lazy-highlight-cleanup nil)
(setq lazy-highlight-max-at-a-time nil)
(setq lazy-highlight-initial-delay 0)

;; artist-mode is allergic to evil
(after 'evil
  (add-hook 'artist-mode-hook 'evil-emacs-state))

;; Emulates surround.vim plugin (https://github.com/tpope/vim-surround)
(require 'evil-surround)
(global-evil-surround-mode 1)

(provide 'init-evil)
