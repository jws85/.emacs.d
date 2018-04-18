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

;; Themes
;; These may come with additional packages to provide various features; go to
;; the theme pages to learn more.

;; This is taken from Spacemacs' "theme megapack"
(setq theme-packages
  '(afternoon-theme
    alect-themes
    ample-theme
    ample-zen-theme
    apropospriate-theme
    anti-zenburn-theme
    badwolf-theme
    birds-of-paradise-plus-theme
    bubbleberry-theme
    busybee-theme
    cherry-blossom-theme
    clues-theme
    color-theme-sanityinc-solarized
    color-theme-sanityinc-tomorrow
    cyberpunk-theme
    dakrone-theme
    darkburn-theme
    darkmine-theme
    darkokai-theme
    darktooth-theme
    django-theme
    dracula-theme
    espresso-theme
    farmhouse-theme
    flatland-theme
    flatui-theme
    gandalf-theme
    gotham-theme
    grandshell-theme
    gruber-darker-theme
    gruvbox-theme
    hc-zenburn-theme
    hemisu-theme
    heroku-theme
    inkpot-theme
    ir-black-theme
    jazz-theme
    jbeans-theme
    light-soap-theme
    lush-theme
    madhat2r-theme
    majapahit-theme
    material-theme
    minimal-theme
    moe-theme
    molokai-theme
    monokai-theme
    monochrome-theme
    mustang-theme
    naquadah-theme
    noctilux-theme
    obsidian-theme
    occidental-theme
    omtose-phellack-theme
    oldlace-theme
    organic-green-theme
    phoenix-dark-mono-theme
    phoenix-dark-pink-theme
    planet-theme
    professional-theme
    purple-haze-theme
    railscasts-theme
    reverse-theme
    seti-theme
    smyx-theme
    soft-charcoal-theme
    soft-morning-theme
    soft-stone-theme
    solarized-theme
    soothe-theme
    spacegray-theme
    subatomic-theme
    subatomic256-theme
    sublime-themes
    sunny-day-theme
    tango-2-theme
    tango-plus-theme
    tangotango-theme
    tao-theme
    toxi-theme
    twilight-anti-bright-theme
    twilight-bright-theme
    twilight-theme
    ujelly-theme
    underwater-theme
    zen-and-art-theme
    zenburn-theme
    ))

(dolist (pkg theme-packages)
  (jws/package-install pkg))

(provide 'jws-themeing)
