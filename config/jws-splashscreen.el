(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((agenda . 5)
                          (projects . 5)
                          (recents . 5))))

(provide 'jws-splashscreen)
