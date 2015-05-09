;; This is sort of a staging point for changes that should be made
;; in language-specific modes.  For now... we're going to keep them
;; here.

;; This was causing havoc with web-mode... 
(setq-default indent-tabs-mode nil)

(defun jws/force-indentation (width tabs-or-spaces)
  "Interactive command that sets tab width, and whether to
indent by tabs or spaces."
  (interactive "nWidth of tabs: \nsTabs or spaces: \n")
  (cond
   ((equal tabs-or-spaces "tabs")
    (setq indent-tabs-mode t))
   ((equal tabs-or-spaces "spaces")
    (setq indent-tabs-mode nil)))
  (setq c-basic-offset width)
  (setq tab-width width)
  (message "Width of tabs: %d; Tabs or spaces: %s" width tabs-or-spaces))

;; Add guess-style
(require 'guess-style)
(autoload 'guess-style-set-variable "guess-style" nil t)
(autoload 'guess-style-guess-variable "guess-style")
(autoload 'guess-style-guess-all "guess-style" nil t)

(add-hook 'c-mode-common-hook 'guess-style-guess-all)

(use-package smart-tabs-mode
  :ensure t
  :config
  (progn
    ;; remove space-after-tab and indentation spaces from whitespace-style
    ;; as per http://www.emacswiki.org/emacs/SmartTabs
    (require 'whitespace)
    (setq whitespace-style (delete 'space-after-tab whitespace-style))
    (setq whitespace-style (delete 'indentation whitespace-style))))

(provide 'config/indent)
