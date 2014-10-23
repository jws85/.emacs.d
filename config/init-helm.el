;; I don't really like helm to navigate projects, but helm-dash looks
;; pretty awesome, so let's go ahead and use it

(use-package helm
  :ensure t
  :init (require 'helm-config)
  :config
  (progn
    (helm-mode 1)

    (after 'diminish
      (diminish 'helm-mode))

    ;; swaps C-z and <tab> -- this makes helm-find-files INFINITELY more usable
    ;; cheers to http://tuhdo.github.io/helm-intro.html for this idea
    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
    (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; terminal <tab>
    (define-key helm-map (kbd "C-z") 'helm-select-action)

    (use-package helm-dash
      :ensure t
      :config
      (progn
	(setq helm-dash-common-docsets '("Emacs Lisp" "C" "JavaScript" "jQuery" "MySQL" "PHP"))))))

(provide 'init-helm)
