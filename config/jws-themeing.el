;; Sets up fontification settings, e.g. themeing, font size...

(defun jws/text-scale-reset ()
  "Reset text scale."
  (interactive)
  (text-scale-set 0))

(defun jws/get-frame-transparency ()
  "Get transparency of current frame."
  (frame-parameter (selected-frame) 'alpha))

(defun jws/clamp (lo hi val)
  (if (< val lo) lo
    (if (> val hi) hi
      val)))

(defun jws/set-frame-transparency (transparency)
  (set-frame-parameter (selected-frame)
                       'alpha
                       (jws/clamp 10 100 transparency)))

(defun jws/increase-transparency ()
  "Make frame more transparent/less opaque."
  (interactive)
  (jws/set-frame-transparency (- (jws/get-frame-transparency) 1)))

(defun jws/decrease-transparency ()
  "Make frame less transparent/more opaque."
  (interactive)
  (jws/set-frame-transparency (+ (jws/get-frame-transparency) 1)))

(defun jws/reset-transparency ()
  "Make frame completely opaque."
  (interactive)
  (jws/set-frame-transparency 100))

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
    ("s" text-scale-decrease "Smaller font")

    ("o" jws/reset-transparency "Completely opaque")
    ("i" jws/increase-transparency "More transparent")
    ("d" jws/decrease-transparency "Less transparent"))

  (global-set-key (kbd "M-j t") 'jws/hydra-themeing/body)
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
