(require 'org-install)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-log-done t
      org-agenda-include-diary t)
(after 'org
  (add-to-list 'org-modules 'org-habit))


(jws/after (hydra)
  (defhydra jws/hydra-org (:exit t)
    ("l" org-store-link "Store link")
    ("a" org-agenda "Agenda")
    ("c" org-capture "Capture")
    ("e" org-export "Export"))

  (global-set-key (kbd "C-c C-c o") 'jws/hydra-org/body)
  (jws/after (evil)
    (define-key evil-normal-state-map (kbd ", o") 'jws/hydra-org/body)))

;; To properly set up org-agenda, you'll need to put some org files with
;; TODO/datestamp stuff in them somewhere, and then put the following in
;; your site-init.el:
;;
;; (require 'jws-path-helpers)
;; (setq org-agenda-files (jws/directory-files "~/path/to/your/org/todo/" t))

;; (setq org-default-notes-file "~/path/to/your/org/notes.org")

(provide 'jws-org-mode)
