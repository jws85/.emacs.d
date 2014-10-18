;; I don't really like helm to navigate projects, but helm-dash looks
;; pretty awesome, so let's go ahead and use it

(use-package helm
  :ensure t
  :config
  (progn
    (use-package helm-dash
      :ensure t
      :config
      (progn
	(setq helm-dash-common-docsets '("C" "JavaScript" "jQuery" "MySQL" "PHP"))))))

(provide 'init-helm)
