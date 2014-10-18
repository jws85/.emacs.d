;; I don't really like helm to navigate projects
;; but helm-dash looks like the dank shit
;; so w/e

(use-package helm
  :config
  (progn
    (use-package helm-dash
      :config
      (progn
	(setq helm-dash-common-docsets '("C" "JavaScript" "jQuery" "MySQL" "PHP"))))))

(provide 'init-helm)
