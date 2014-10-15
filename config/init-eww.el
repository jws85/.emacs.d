;; use eww to browse everything
(setq browse-url-browser-function 'eww-browse-url)

;; the following are from https://github.com/GriffinSchneider/emacs-config/blob/master/eww-customizations.el
(eval-after-load "eww"
  '(progn
     ;; Use vim keybindings for searching
     (define-key eww-mode-map (read-kbd-macro "/") 'evil-search-forward)
     (define-key eww-mode-map (read-kbd-macro "?") 'evil-search-backward)
     (define-key eww-mode-map (read-kbd-macro "n") 'evil-search-next)
     (define-key eww-mode-map (read-kbd-macro "N") 'evil-search-previous)
     ;; Use vim keybindings for scrolling
     (define-key eww-mode-map (read-kbd-macro "j") 'evil-next-line)
     (define-key eww-mode-map (read-kbd-macro "k") 'evil-previous-line)
     (define-key eww-mode-map (read-kbd-macro "C-j") (lambda () (interactive) (next-line 2) (scroll-up 2)))
     (define-key eww-mode-map (read-kbd-macro "C-k") (lambda () (interactive) (scroll-down 2) (previous-line 2)))
     (define-key eww-mode-map (read-kbd-macro "d") 'evil-scroll-down)
     (define-key eww-mode-map (read-kbd-macro "u") 'evil-scroll-up)
     ;; Use sane keybindings for forward/back
     (define-key eww-mode-map (read-kbd-macro "b") 'eww-back-url)
     (define-key eww-mode-map (read-kbd-macro "<backspace>") 'eww-back-url)
     (define-key eww-mode-map (read-kbd-macro "S-<backspace>") 'eww-forward-url)))

(provide 'init-eww)
