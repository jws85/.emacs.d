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
  '((unihan . ((#x4e00 . #x9fff))) ; The Han unification block
                                   ; e.g. where Unicode (tried to) unify the pictoral
                                   ; hanzi/kanji/hanja/chữ nôm characters

    ;; Chinese/官话/官話/粵語/客家話/et cetera
    ;; From https://stackoverflow.com/a/1366113
    (zh . ((#x3400 . #x4dbf)   ; unihan ext A
           (#x20000 . #x2a6df) ; unihan ext B
           (#x2a700 . #x2b73f) ; unihan ext C
           (#x2b740 . #x2b81f) ; unihan ext D
           (#x2b740 . #x2b81f) ; unihan ext D
           (#x2b820 . #x2ceaf) ; unihan ext E
           (#x2f800 . #x2fa1f))) ; cjk compatibility ideographs supplement

    ;; Korean/한국어
    (kr . ((#x1100 . #x11ff) ; jamo (parts of syllables)
           (#x3130 . #x318f) ; compatibility jamo
           (#xac00 . #xd7ff))) ; hangul syllables

    ;; Japanese/日本語
    (jp . ((#x3000 . #x303f) ; punctuation
           (#x3040 . #x309f) ; hiragana
           (#x30a0 . #x30ff) ; katakana
           (#xff00 . #xffef))))) ; half-width katakana/full-width roman

;; If you are emphasizing Japanese, for instance, you'll map your Japanese
;; font to the 'unihan and 'jp blocks.  If Chinese, you'd map to 'unihan
;; and 'zh.  (I'm not sure how Korean does it, though I do know that hanja
;; are used in given names.)

;; There can be small but noticeable differences between the languages in
;; how a specific Unicode codepoint is represented.  See here for instance:
;; https://en.wikipedia.org/wiki/Han_unification#Examples_of_language-dependent_glyphs

;; I am not a native speaker of any of these languages, and am sort of
;; extremely slowly learning Japanese.  So I have probably made very bad
;; mistakes.  I'd like to know if I did!

;;; Here is some example code:
;;
;; ;; Font mapping for Korean
;; (jws/font-map-to-range (font-spec :name "Noto Sans CJK KR")
;;                        (cdr (assq 'kr jws/unicode-ranges-by-language)))
;;
;; ;; Font mapping for Japanese
;; (jws/font-map-to-range (font-spec :name "Noto Sans CJK JP")
;;                        (cdr (assq 'unihan jws/unicode-ranges-by-language)))
;; (jws/font-map-to-range (font-spec :name "Noto Sans CJK JP")
;;                        (cdr (assq 'jp jws/unicode-ranges-by-language)))

(provide 'jws-fonts)

;;; jws-fonts.el ends here
