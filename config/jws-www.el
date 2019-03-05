;; eww is still kind of a toy... but sometimes it can come in handy

;; use eww to browse everything
(setq browse-url-browser-function 'eww-browse-url)

(defvar jws/eww-home-page "https://duckduckgo.com/html/?kd=1")

(defun jws/eww-home ()
  (interactive)
  (eww jws/eww-home-page))

(define-key jws/leader-map (kbd "n n") 'jws/eww-home)

;; Opens links in browse-url-browser-function
(use-package ace-link
  :after avy
  :ensure t
  :config
  (progn
    ;; By default, this adds 'o' keybind to eww and a few other modes
    (ace-link-setup-default)
    (defun jws/ace-link-contextual ()
      (interactive)
      (if (eq major-mode 'org-mode)
          (ace-link-org)
        (ace-link-addr)))
    (global-set-key (kbd "M-j n o") 'jws/ace-link-contextual)
    (after 'evil (define-key evil-normal-state-map (kbd "SPC n o") 'jws/ace-link-contextual))))

;; Web search
(after 'counsel
  (require 'counsel-surfraw)
  (define-key jws/leader-map (kbd "n s") 'counsel-surfraw))

(provide 'jws-www)
