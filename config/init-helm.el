;; I don't really like helm to navigate projects
;; but helm-dash looks like the dank shit
;; so w/e

(use-package helm
  :config
  (progn
    (use-package helm-dash)))

(provide 'init-helm)
