;; C-like languages

(add-hook 'c-mode-common-hook
          (lambda ()
            (modify-syntax-entry ?_ "w")  ; underscore considered part of a "word"
            (smart-tabs-insinuate 'c 'c++ 'java)))

(provide 'config/clangs)
