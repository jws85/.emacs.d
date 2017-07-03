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

(defvar jws/org-journal-dir (concat jws/org-dir "journal/")
  "The directory where org-mode todo/agenda files live")

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(setq org-log-done t
      org-agenda-include-diary t
      org-refile-targets '((nil . (:maxlevel . 6))))

(defun jws/load-org-settings ()
  "Run this after changing jws/org*dir."
  (interactive)
  (setq org-default-notes-file (concat jws/org-dir "notes.org")
        org-agenda-files (jws/directory-files jws/org-todo-dir t)))

(if (and (file-exists-p jws/org-dir) (file-exists-p jws/org-todo-dir))
    (jws/load-org-settings)
  (message "Please set up jws/org-dir and jws/org-todo-dir to use org-agenda, etc."))

(after 'org
  ;; Adding habits (recurring events)
  (add-to-list 'org-modules 'org-habit))

(after 'org-agenda
  ;; Enabling vim bindings in the agenda
  (evil-add-hjkl-bindings org-agenda-mode-map 'emacs)
  (define-key org-agenda-mode-map (kbd "L") 'org-agenda-log-mode)
  (define-key org-agenda-mode-map (kbd "C") 'org-agenda-capture)
  (define-key org-agenda-mode-map (kbd "d") 'org-agenda-goto-date))

;; http://orgmode.org/manual/Capture-templates.html
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (concat jws/org-todo-dir "unfiled.org") "Unfiled Tasks")
         "* TODO %?\n  %i")
        ("l" "Link" entry (file+headline (concat jws/org-dir "links.org") "Uncategorized")
         "* %?")
        ("j" "Journal" entry (file+datetree (concat jws/org-journal-dir "current.org"))
         "* %?\nEntered on %U\n  %i")))

(defun jws/show-org-agenda ()
  "Run org-agenda and bring its buffer to the front.

Useful on startup (e.g. in site-init.el):
(setq initial-buffer-choice #'jws/show-org-agenda)

This displays the org-agenda at startup."
  (interactive)
  (org-agenda-list)
  (get-buffer "*Org Agenda*"))

(jws/after (hydra)
  (defun jws/open-org-dir ()
    (interactive)
    (counsel-find-file jws/org-dir))

  (defhydra jws/hydra-org (:exit t)
    ("f" jws/open-org-dir "Open org dir")
    ("l" org-store-link "Store link")
    ("a" org-agenda "Agenda")
    ("c" org-capture "Capture")
    ("e" org-export "Export"))

  (global-set-key (kbd "M-j o") 'jws/hydra-org/body)
  (jws/after (evil)
    (define-key evil-normal-state-map (kbd ", o") 'jws/hydra-org/body)))

(provide 'jws-org-mode)
