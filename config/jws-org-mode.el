;; Note:
;;
;; My org-mode folder structure looks like the following:
;;  * root/
;;     * todo/
;;        - latest.org
;;        - work.org
;;        - plans.org
;;        - hobbies.org
;;        - holidays.org
;;        - ...
;;     * journal/
;;        - latest.org
;;        - ...

(require 'jws-path-helpers)

(require 'org-install)

(defvar jws/org-dir (expand-file-name "~/org/")
  "The directory where org-mode files live")

(defvar jws/org-todo-dir (concat jws/org-dir "todo/")
  "The directory where org-mode todo/agenda files live")

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(setq org-log-done t
      org-agenda-include-diary t
      org-default-notes-file (concat jws/org-dir "notes.org")
      org-agenda-files (jws/directory-files jws/org-todo-dir t))

(after 'org
  (add-to-list 'org-modules 'org-habit))

;(setq org-capture-templates
;      '(("t" "Todo" entry (file+headline org-default-notes-file "Tasks"))))

(jws/after (hydra)
  (defhydra jws/hydra-org (:exit t)
    ("l" org-store-link "Store link")
    ("a" org-agenda "Agenda")
    ("c" org-capture "Capture")
    ("e" org-export "Export"))

  (global-set-key (kbd "C-c C-c o") 'jws/hydra-org/body)
  (jws/after (evil)
    (define-key evil-normal-state-map (kbd ", o") 'jws/hydra-org/body)))

(provide 'jws-org-mode)
