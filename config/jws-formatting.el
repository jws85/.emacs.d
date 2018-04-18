;; Settings for indentation in coding files.  Includes a "formatting"
;; hydra that can be used to change these settings on the fly.

;; This was causing havoc with web-mode...
(setq-default indent-tabs-mode nil)

;; Add guess-style
(require 'guess-style)
(autoload 'guess-style-set-variable "guess-style" nil t)
(autoload 'guess-style-guess-variable "guess-style")
(autoload 'guess-style-guess-all "guess-style" nil t)

(add-hook 'c-mode-common-hook 'guess-style-guess-all)

;; Defining functions for the hydra
(defun jws/toggle-tabs-spaces ()
  (interactive)
  (if (equal indent-tabs-mode t)
			(setq indent-tabs-mode nil)
		(setq indent-tabs-mode t)))

(defun jws/set-tab-stop (inc)
  (setq c-basic-offset inc)
  (setq tab-width inc))

(defun jws/get-indent-char ()
  (interactive)
  (if (equal indent-tabs-mode t) "tabs" "spaces"))

;; Defining a hydra to change formatting settings...
(defhydra jws/hydra-formatting (:exit nil :columns 4)
  "
INDENTATION | Char: %s(jws/get-indent-char) | Size: %`tab-width | Electric: %`electric-indent-mode
"
  ("2" (jws/set-tab-stop 2) "Set tab stop to 2")
  ("4" (jws/set-tab-stop 4) "Set tab stop to 4")
  ("8" (jws/set-tab-stop 8) "Set tab stop to 8")
  ("t" jws/toggle-tabs-spaces "Toggle tab/space indent")
  ("e" electric-indent-mode "Toggle electric indent")
  ("TAB" tabify "Tabify the selection")
  ("RET" untabify "Spacify the selection")
  ("w" whitespace-mode "Display whitespace"))

(define-key jws/leader-map (kbd "F") 'jws/hydra-formatting/body)

(provide 'jws-formatting)
