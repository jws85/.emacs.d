(use-package python
  :ensure t
  :mode ("\\.py\\'" . python-mode))

(use-package elpy
  :ensure t
  :defer t
  :init (with-eval-after-load 'python (elpy-enable)))

(provide 'jws-python)
