;; use eww to browse everything
(setq browse-url-browser-function 'eww-browse-url)

;; the following are from https://github.com/GriffinSchneider/emacs-config/blob/master/eww-customizations.el
(eval-after-load "eww"
  '(progn
     ;; Use vim keybindings for searching
     (define-key eww-mode-map (kbd "/") 'evil-search-forward)
     (define-key eww-mode-map (kbd "?") 'evil-search-backward)
     (define-key eww-mode-map (kbd "n") 'evil-search-next)
     (define-key eww-mode-map (kbd "N") 'evil-search-previous)

     ;; Use vim keybindings for scrolling
     (evil-add-hjkl-bindings eww-mode-map 'emacs)

     ;; Use sane keybindings for forward/back
     (define-key eww-mode-map (kbd "<backspace>") 'eww-back-url)
     (define-key eww-mode-map (kbd "C-<backspace>") 'eww-forward-url)))

(provide 'init-eww)
