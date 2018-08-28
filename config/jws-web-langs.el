;; CSS ------------------------------------------------------------------------

;; Color functions
;; From http://www.emacswiki.org/emacs/HexColour
(defun jws/hexcolor-luminance (color)
  "Calculate the luminance of a color string (e.g. \"#ffaa00\", \"blue\").
  This is 0.3 red + 0.59 green + 0.11 blue and always between 0 and 255."
  (let* ((values (x-color-values color)))
   (r (car values))
   (g (cadr values))
   (b (caddr values)
    (floor (+ (* .3 r) (* .59 g) (* .11 b)) 256))))


(defun jws/hexcolor-add-to-font-lock ()
  (interactive)
  (font-lock-add-keywords nil
                  `((,(concat "#[0-9a-fA-F]\\{3\\}[0-9a-fA-F]\\{3\\}?\\|"
                              (regexp-opt (x-defined-colors) 'words))
                     (0 (let ((color (match-string-no-properties 0)))
                          (put-text-property
                           (match-beginning 0) (match-end 0)
                           'face `((:foreground ,(if (> 128.0 (jws/hexcolor-luminance color))
                                                     "white" "black"))
                                   (:background ,color)))))))))

(add-hook 'css-mode-hook 'jws/hexcolor-add-to-font-lock)

(use-package scss-mode
  :ensure t
  :mode (("\\.scss\\'" . scss-mode)))

;; Coffee ---------------------------------------------------------------------
;; I don't use Coffeescript; I think I pulled this in because some other
;; library I wanted to use used it, and I wanted to see its code.

(use-package coffee-mode
  :ensure t
  :mode (("\\.coffee\\'" . coffee-mode))
  :config
  (progn
    (setq coffee-tab-width 4)))

;; PHP ------------------------------------------------------------------------

;; Autocomplete
(use-package company-php
  :ensure t
  :config
  (progn
    (defun jws/company-php-setup ()
      (require 'company-php)
      (company-mode t)
      (ac-php-core-eldoc-setup)
      (after 'diminish
        (diminish 'eldoc-mode))
      (make-local-variable 'company-backends)
      (add-to-list 'company-backends 'company-ac-php-backend))))

(defun jws/php-definition-of-word ()
  (modify-syntax-entry ?_ "w"))

(use-package php-mode
  :ensure t
  :config
  (progn
    (setq c-basic-offset 4)
    (add-hook 'php-mode-hook #'jws/php-definition-of-word)
    (add-hook 'php-mode-hook #'jws/company-php-setup)))

;; web-mode -------------------------------------------------------------------
;; Emacs does quite well in handling monolingual PHP files.  But a LOT of
;; legacy PHP contains commingled JavaScript, CSS, and HTML.  These files
;; are not suitably handled by php-mode.
;;
;; When I first came across code like this, I tried mumamo-mode, and
;; in doing so took days off my lifespan.  Absolutely frustrating.  I
;; ended up switching to vim (which had at the time much better
;; support for this kind of PHP code) for several years; in doing so,
;; I assimilated the keybindings.  So we have legacy PHP code to blame
;; for this huge emacs configuration with lots of vim affordances in
;; it >_<
;;
;; I finally switched back to emacs full time with the web-mode package,
;; which displays these commingled files about as well as could be
;; expected.  It ain't the best solution; web-mode can be kind of buggy,
;; but it is worth it to have a nice editing environment like this.

(use-package web-mode
  :ensure t
  :mode (("\\.html?\\'" . web-mode))
   ("\\.php\\'" . web-mode)
   ("\\.phtml\\'" . web-mode)
   ("\\.tpl\\.php\\'" . web-mode)
   ("\\.[agj]sp\\'" . web-mode)
   ("\\.as[cp]x\\'" . web-mode)
   ("\\.erb\\'" . web-mode)
   ("\\.mustache\\'" . web-mode)
   ("\\.djhtml\\'" . web-mode)
  :init (require 'web-mode)
  :config
  (progn
    (setq web-mode-enable-auto-pairing nil
          web-mode-enable-auto-quoting nil)

    ;; uh, why isn't this happening by default?
    (add-hook 'web-mode-hook (lambda () (run-hooks 'prog-mode-hook)))

    ;; still broken...
    (add-hook 'web-mode-hook
              (lambda ()
                (let ((cur-engine "php"))
                  (cond
                   ((string= cur-engine "php")
                    (jws/company-php-setup))))))))

;; REST Client ----------------------------------------------------------------

(use-package restclient
  :ensure t
  :config
  (setq auto-mode-alist (append '(("\\.restclient$" . restclient-mode))
                                auto-mode-alist)))

(provide 'jws-web-langs)
