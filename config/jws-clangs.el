;; C-like languages

;; Golang
;; Useful: https://tleyden.github.io/blog/2014/05/22/configure-emacs-as-a-go-editor-from-scratch/
(defun jws/golang-hook ()
  ;; Format code on save (needs go get golang.org/x/tools/cmd/goimports)
  (set gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)

  ;; Compile
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))

  ;; Jump around code
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark))

(use-package go-mode
  :ensure t
  :mode "\\.go\\'"
  :config
  (add-hook 'go-mode-hook 'jws/golang-hook))

;; Qt QML -- which is a JavaScript derivative and thus a curly-brace C descendant,
;; even if it doesn't work like one!

(use-package qml-mode
  :ensure t
  :mode "\\.qml\\'")

;; C and other similar languages

(add-hook 'c-mode-common-hook
          (lambda ()
            (modify-syntax-entry ?_ "w")))  ; underscore considered part of a "word"

(provide 'jws-clangs)
