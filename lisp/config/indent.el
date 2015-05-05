;; This is sort of a staging point for changes that should be made
;; in language-specific modes.  For now... we're going to keep them
;; here.

;; This was causing havoc with web-mode... 
(setq-default indent-tabs-mode nil)

;; Add guess-style
(require 'guess-style)
(autoload 'guess-style-set-variable "guess-style" nil t)
(autoload 'guess-style-guess-variable "guess-style")
(autoload 'guess-style-guess-all "guess-style" nil t)

(add-hook 'c-mode-common-hook 'guess-style-guess-all)

(provide 'config/indent)
