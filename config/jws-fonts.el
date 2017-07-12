;;; jws-fonts.el -- Font-related code

;;; Commentary:

;;; Code:

(defun jws/font-map-to-range (font-spec char-ranges)
  "Maps the FONT-SPEC to the specified Unicode CHAR-RANGES."
  (cl-loop for (lo-char . hi-char) in char-ranges
           do (set-fontset-font "fontset-default"
                                (cons (decode-char 'ucs lo-char)
                                      (decode-char 'ucs hi-char))
                                font-spec)))

;; Maps languages to the parts of Unicode that cover their
;; scripts.  These ranges can be passed to jws/font-map-to-range.
;; I will add languages as needed.
(defvar jws/unicode-ranges-by-language
  '((kr . ((#x1100 . #x11ff) ; jamo (parts of syllables)
           (#x3130 . #x318f) ; compatibility jamo
           (#xac00 . #xd7ff))) ; hangul syllables
    (jp . ((#x3000 . #x303f) ; punctuation
           (#x3040 . #x309f) ; hiragana
           (#x30a0 . #x30ff) ; katakana
           (#x4e00 . #x9faf) ; unihan kanji
           (#xff00 . #xffef))))) ; half-width katakana/full-width roman

;;; Here is some example code:
;;
;; ;; Font mapping for Korean
;; (jws/font-map-to-range (font-spec :name "Noto Sans CJK KR")
;;                        (cdr (assq 'kr jws/unicode-ranges-by-language)))
;;
;; ;; Font mapping for Japanese
;; (jws/font-map-to-range (font-spec :name "Noto Sans CJK JP")
;;                        (cdr (assq 'jp jws/unicode-ranges-by-language)))

(provide 'jws-fonts)

;;; jws-fonts.el ends here
