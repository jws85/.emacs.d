;; Sets up fontification settings, e.g. themeing, font size...

(defun jws/text-scale-reset ()
  "Reset text scale."
  (interactive)
  (text-scale-set 0))

;; Focus on some text at a time
(use-package focus :ensure t)

;; Wrap all this together into keybindings
(after 'hydra
  (defhydra jws/hydra-themeing ()
    ("f" focus-mode "Focus")
    ("t" load-theme "Load theme")

    ("=" jws/text-scale-reset "Reset font size")
    ("r" jws/text-scale-reset "Reset font size")

    ("+" text-scale-increase "Larger font")
    ("l" text-scale-increase "Larger font")

    ("-" text-scale-decrease "Smaller font")
    ("s" text-scale-decrease "Smaller font"))

  (global-set-key (kbd "C-c C-c t") 'jws/hydra-themeing/body)
  (after 'evil
    (define-key evil-normal-state-map (kbd ", t") 'jws/hydra-themeing/body)))

;; Color themes

;; Below I install a few themes I liked.

;; I include a port of the Vim "Jellybeans" theme in the ~/.emacs.d/colors/ folder;
;; it can be simply loaded with load-theme.  I should put this in MELPA.

;; Be forewarned that many themes will often define library faces that are different
;; than other themes will, so the end result is that you may have some ugly colors
;; from a previous theme clashing with the currently selected one...

;; FIXME use-package has no facilities for installing a package but never loading
;; it.  This is problematic for installing themes, which often load faces when their
;; library is loaded...

;; Theme families
;; These may come with additional packages to provide various features; go to
;; the theme pages to learn more.
(package-install 'moe-theme)
(package-install 'solarized-theme)

;; Dark themes
(package-install 'cyberpunk-theme)
(package-install 'zenburn-theme)

;; Light themes
(package-install 'leuven-theme)

(provide 'jws-themeing)
