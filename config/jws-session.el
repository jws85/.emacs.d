;; This should go through my buffers once a day, early in the morning,
;; and get rid of a lot of cruft (any buffer older than three days
;; old, plus temp buffer junk) BTW, if I'm up at 3:30 AM, something is
;; seriously wrong.
(require 'midnight)
(midnight-delay-set 'midnight-delay "3:30 AM")

(provide 'jws-session)
