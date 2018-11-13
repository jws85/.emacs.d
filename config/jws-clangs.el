;; C-like languages

;; Golang
;; Useful: https://tleyden.github.io/blog/2014/05/22/configure-emacs-as-a-go-editor-from-scratch/
(use-package go-mode
  :ensure t
  :mode "\\.go\\'"
  :config
  (add-hook 'before-save-hook 'gofmt-before-save))

(add-hook 'c-mode-common-hook
          (lambda ()
            (modify-syntax-entry ?_ "w")))  ; underscore considered part of a "word"

(provide 'jws-clangs)
