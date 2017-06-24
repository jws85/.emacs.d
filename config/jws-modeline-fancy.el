(use-package spaceline
  :ensure t
  :init (require 'spaceline-config))

(use-package all-the-icons
  :ensure t
  :after spaceline
  :init (require 'all-the-icons))

(use-package spaceline-all-the-icons
  :ensure t
  :after all-the-icons
  :init (require 'spaceline-all-the-icons)
  :config
  (progn
    (spaceline-all-the-icons--setup-paradox)
    (spaceline-all-the-icons--setup-anzu)
    (spaceline-all-the-icons-theme)))

(provide 'jws-modeline-fancy)
