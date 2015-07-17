;; jellybeans-theme.el
;; Author:   J. W. Smith
;; License:  MIT

;; The intent originally was to make a Emacs clone of Jellybeans:
;; https://github.com/nanotech/jellybeans.vim
;;
;; This was my favorite theme in Vim.  It's still pretty close, I
;; think, but there is probably some divergence from the original
;; jellybeans.vim.
;;
;; It should color most (if not all) language elements, the mode line,
;; and company-mode, ido-mode, and helm-mode.

(deftheme jellybeans
  "Created 2013-11-05.")

(custom-theme-set-faces
 'jellybeans
 '(cursor ((t (:background "#b0d0f0"))))
 '(fixed-pitch ((t (:family "Monospace"))))
 '(variable-pitch ((t (:family "Sans Serif"))))
 '(escape-glyph ((((background dark)) (:foreground "cyan")) (((type pc)) (:foreground "magenta")) (t (:foreground "brown"))))
 '(minibuffer-prompt ((t (:foreground "#8fbfdc" :weight bold))))
 '(highlight ((t (:background "#1c1c1c"))))
 '(region ((t (:background "#404040"))))
 '(shadow ((((class color grayscale) (min-colors 88) (background light)) (:foreground "grey50")) (((class color grayscale) (min-colors 88) (background dark)) (:foreground "grey70")) (((class color) (min-colors 8) (background light)) (:foreground "green")) (((class color) (min-colors 8) (background dark)) (:foreground "yellow"))))
 '(secondary-selection ((((class color) (min-colors 88) (background light)) (:background "yellow1")) (((class color) (min-colors 88) (background dark)) (:background "SkyBlue4")) (((class color) (min-colors 16) (background light)) (:background "yellow")) (((class color) (min-colors 16) (background dark)) (:background "SkyBlue4")) (((class color) (min-colors 8)) (:foreground "black" :background "cyan")) (t (:inverse-video t))))
 '(trailing-whitespace ((((class color) (background light)) (:background "red1")) (((class color) (background dark)) (:background "red1")) (t (:inverse-video t))))
 '(font-lock-builtin-face ((t (:foreground "#8fbfdc"))))
 '(font-lock-comment-delimiter-face ((default (:inherit (font-lock-comment-face)))))
 '(font-lock-comment-face ((t (:foreground "#888888" :slant italic))))
 '(font-lock-constant-face ((t (:foreground "#8197bf"))))
 '(font-lock-doc-face ((t (:inherit (font-lock-string-face)))))
 '(font-lock-function-name-face ((t (:foreground "#fad07a"))))
 '(font-lock-keyword-face ((t (:foreground "#8fbfdc"))))
 '(font-lock-negation-char-face ((t nil)))
 '(font-lock-preprocessor-face ((t (:foreground "#8fbfdc"))))
 '(font-lock-regexp-grouping-backslash ((t (:inherit (bold)))))
 '(font-lock-regexp-grouping-construct ((t (:inherit (bold)))))
 '(font-lock-string-face ((t (:foreground "#99ad6a"))))
 '(font-lock-type-face ((t (:foreground "#ffb964"))))
 '(font-lock-variable-name-face ((t (:foreground "#cf6a4c"))))
 '(font-lock-warning-face ((t (:inherit (error)))))
 '(button ((t (:inherit (link)))))
 '(link ((t (:foreground "#8fbfdc" :underline t))))
 '(link-visited ((default (:inherit (link))) (((class color) (background light)) (:foreground "magenta4")) (((class color) (background dark)) (:foreground "violet"))))
 '(fringe ((t (:background "#1c1c1c"))))
 '(header-line ((default (:inherit (mode-line))) (((type tty)) (:underline (:color foreground-color :style line) :inverse-video nil)) (((class color grayscale) (background light)) (:box nil :foreground "grey20" :background "grey90")) (((class color grayscale) (background dark)) (:box nil :foreground "grey90" :background "grey20")) (((class mono) (background light)) (:underline (:color foreground-color :style line) :box nil :inverse-video nil :foreground "black" :background "white")) (((class mono) (background dark)) (:underline (:color foreground-color :style line) :box nil :inverse-video nil :foreground "white" :background "black"))))
 '(tooltip ((t (:foreground "systeminfotext" :background "systeminfowindow" :inherit (variable-pitch)))))
 '(mode-line ((t (:background "#384048" :foreground "#e8e8d3" :box (:line-width -1 :style released-button)))))
 '(mode-line-buffer-id ((t (:weight bold))))
 '(mode-line-emphasis ((t (:weight bold))))
 '(mode-line-highlight ((((class color) (min-colors 88)) (:box (:line-width 2 :color "grey40" :style released-button))) (t (:inherit (highlight)))))
 '(mode-line-inactive ((t (:inherit mode-line :background "#151515" :foreground "#e8e8d3" :box (:line-width -1 :color "grey40") :weight light))))
 '(isearch ((t (:background "#312028" :foreground "#f0a0c0" :underline t))))
 '(isearch-fail ((t (:inherit isearch :foreground "red"))))
 '(lazy-highlight ((t (:inherit isearch :foreground "#b080a0"))))
 '(isearch-lazy-highlight-face ((t (:inherit isearch :foreground "#b080a0"))))
 '(match ((t (:inherit isearch))))
 '(next-error ((t (:inherit (region)))))
 '(query-replace ((t (:inherit (isearch)))))
 '(default ((t (:inherit nil :background "#151515" :foreground "#e8e8d3"))))

 ;; company
 '(company-tooltip ((t (:background "#606060"))))
 '(company-tooltip-selection ((t (:background "#fad07a" :foreground "#353535"))))
 '(company-scrollbar-bg ((t (:background "white"))))
 '(company-scrollbar-fg ((t (:background "#808080"))))
 '(company-preview ((t (:background "#a4416f"))))
 '(company-preview-commmon ((t (:inherit company-preview :foreground "#d0d0d0"))))
 '(company-preview-search ((t (:inherit company-preview :foreground "#fad07a"))))
 '(company-tooltip-annotation ((t (:inherit company-tooltip :foreground "#d0d0d0"))))
 '(company-tooltip-common ((t (:inherit company-tooltip :foreground "#8fbfdc"))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :foreground "#3c89b8"))))

 ;; helm
 '(helm-source-header ((t (:inherit nil :height 1.2 :weight bold :background "#a4416f" :foreground "white"))))
 '(helm-selection ((t (:inherit nil :underline t :foreground "#fad07a"))))
 '(helm-separator ((t (:inherit nil :foreground "#f0a0c0"))))
 '(helm-buffer-directory ((t (:inherit nil :background "#4c4c4c"))))
 '(helm-ff-file ((t (:inherit default))))
 '(helm-ff-directory ((t (:inherit nil :foreground "#8fbfdc"))))
 '(helm-ff-executable ((t (:inherit nil :foreground "#99ad6a"))))
 '(helm-ff-invalid-symlink ((t (:inherit (error)))))
 '(helm-ff-symlink ((t (:inherit nil :foreground "#f0a0c0"))))
 '(helm-history-deleted ((t (:inherit (error)))))
 '(helm-history-remote ((t (:inherit nil :foreground "#cf6a4c"))))

 ;; ido
 '(ido-subdir ((t (:inherit nil :foreground "#8197bf"))))
 '(ido-first-match ((t (:inherit nil :foreground "orange" :weight bold))))
 '(ido-only-match ((t (:inherit nil :foreground "#f0a0c0" :weight bold))))
 '(ido-indicator ((t (:inherit nil :underline t))))

 ;; diff
 '(diff-added ((t (:inherit diff-changed :foreground "#99ad6a"))))
 '(diff-removed ((t (:inherit diff-changed :foreground "#cf6a4c"))))
 )

(provide-theme 'jellybeans)
