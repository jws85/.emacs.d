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

  (define-key jws/leader-map (kbd "t") 'jws/hydra-themeing/body))

;;; Color themes

(if (not (package-installed-p 'doom-themes))
    (jws/package-install 'doom-themes))

(provide 'jws-themeing)
