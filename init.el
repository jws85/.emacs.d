;; You *MUST* have this here or Emacs throws a tantrum and puts
;; it there for you anyways.
(package-initialize)

;; Untangle my config from its org-mode file and load it
(org-babel-load-file (concat user-emacs-directory "config.org"))
