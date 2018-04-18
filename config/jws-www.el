;; eww is still kind of a toy... but sometimes it can come in handy

;; use eww to browse everything
(setq browse-url-browser-function 'eww-browse-url)

(defvar jws/eww-home-page "https://duckduckgo.com/html/?kd=1")

(defun jws/eww-home ()
  (interactive)
  (eww jws/eww-home-page))

(define-key jws/leader-map (kbd "u w w") 'jws/eww-home)

;; Opens links in browse-url-browser-function
(use-package ace-link
  :after avy
  :ensure t
  :config
  (progn
    ;; By default, this adds 'o' keybind to eww and a few other modes
    (ace-link-setup-default)
    (after 'org
      (define-key org-mode-map (kbd "M-o") 'ace-link-org))
    (global-set-key (kbd "M-o") 'ace-link-addr)))

;; Web search
(after 'counsel
  (require 'counsel-surfraw)
  (define-key jws/leader-map (kbd "u w s") 'counsel-surfraw))

;; Much of the following is from https://github.com/GriffinSchneider/emacs-config/blob/master/eww-customizations.el
(eval-after-load "eww"
  '(progn
     (add-to-list 'evil-emacs-state-modes 'eww-mode)

     ;; Use vim keybindings for scrolling -- [FIXME] broke typing hjkl into text fields :(
     ;; (evil-add-hjkl-bindings eww-mode-map 'emacs)

     ;; kd=-1 disables duckduckgo JavaScript redirect
     (setq eww-search-prefix "https://duckduckgo.com/html/?kd=-1&q=")

     ;; Use vim keybindings for searching
     (define-key eww-mode-map (kbd "/") 'evil-search-forward)
     (define-key eww-mode-map (kbd "?") 'evil-search-backward)
     (define-key eww-mode-map (kbd "n") 'evil-search-next)
     (define-key eww-mode-map (kbd "N") 'evil-search-previous)

     ;; Rebind bookmarking
     (define-prefix-command 'eww-bookmark-map)
     (define-key eww-mode-map (kbd "B") 'eww-bookmark-map)
     (define-key eww-bookmark-map (kbd "a") 'eww-add-bookmark)
     (define-key eww-bookmark-map (kbd "A") 'eww-add-bookmark)
     (define-key eww-bookmark-map (kbd "l") 'eww-list-bookmarks)
     (define-key eww-bookmark-map (kbd "L") 'eww-list-bookmarks)

     (define-key eww-mode-map (kbd "r") 'eww-reload)
     (define-key eww-mode-map (kbd "g") 'eww)

     ;; Use sane keybindings for forward/back
     (define-key eww-mode-map (kbd "f") 'eww-forward-url)
     (define-key eww-mode-map (kbd "b") 'eww-back-url)
     (define-key eww-mode-map (kbd "<backspace>") 'eww-back-url)
     (define-key eww-mode-map (kbd "C-<backspace>") 'eww-forward-url)

     (define-key eww-mode-map (kbd "y") 'eww-copy-page-url)
     (define-key eww-bookmark-mode-map (kbd "RET") 'eww-bookmark-browse)
     (define-key eww-bookmark-mode-map (kbd "q") 'quit-window)))

(provide 'jws-www)
