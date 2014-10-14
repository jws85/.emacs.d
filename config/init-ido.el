(require 'ido)
(require 'flx-ido)

;; enables ido-mode in as many places as possible (smex enables it in M-x)
(ido-mode t)
(ido-everywhere t)

;; enables a 'nicer' matching method (warning: possible performance killer)
(flx-ido-mode t)
(setq ido-use-faces nil)

;; ido niceties in the M-x command interface
(smex-initialize)

;; ido is super-automated.  This is awesome in a lot of ways, but it often
;; gets in the way of me actually doing work, e.g. creating new files.

;; disable searching in unrelated directories; e.g. I'm in ~/a/b/c and
;; decide to make a new file ~/a/b/c/foobar, but I was recently in ~/z
;; which has ~/z/foobar; ido will present me with ~/z/foobar which is
;; often infuriating
(setq ido-auto-merge-work-directories-length -1)

;; require pressing enter to confirm the current directory
(setq ido-confirm-unique-completion nil)
(setq ido-enable-tramp-completion nil)

(provide 'init-ido)
