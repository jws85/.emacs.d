;;; jws-org-mode.el -- Org-mode settings

;;; Commentary:
;;
;; I've redone my org-mode strategy because my old one was not
;; working for me.
;;
;; The idea is to try to follow GTD, so I have these files under
;; the journal/ directory under my $orgroot:
;;
;;  - inbox.org      Where unfiled stuff goes
;;  - gtd.org        Repository for current projects
;;  - someday.org    Repository for postponed projects
;;  - tickler.org    A 'tickler' file (still don't like that name)
;;  - recurring.org  Where recurring events go (like birthdays)
;;  - finished.org   Where finished stuff gets archived to
;;
;; I am planning on following more or less the methodology
;; outlined here:
;;
;; https://emacs.cafe/emacs/orgmode/gtd/2017/06/30/orgmode-gtd.html
;;
;; It's a lot simpler and cleaner than what I was (not) doing.
;; The one difference is that I have daily and weekly reviews
;; scheduled on fixed times in the tickler file, because I need
;; the push to do it.
;;
;; All of this is synced up using Dropbox, and on some computers I
;; leave the Emacs window open; thus the reason for the autosaving.

;;; Code:

(require 'seq) ; required for seq-filter

(use-package org
  :ensure t
  :init (require 'org-install))

;; basic configuration ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar jws/org-dir (expand-file-name "~/Org/")
  "The directory where `org-mode' files live.")

(defvar jws/org-agenda-dir (concat jws/org-dir "agenda/")
  "The directory where `org-mode' agenda files live.")

(defvar jws/org-journal-dir (concat jws/org-dir "journal/")
  "The directory where `org-mode' journal files live.")

(defvar jws/org-notes-dir (concat jws/org-dir "notes/")
  "The directory where `deft' notes files live.")

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(after 'org
  ;; Adding habits (recurring events)
  (add-to-list 'org-modules 'org-habit))

;; Render code inside code blocks
(setq org-src-fontify-natively t)

;; org-agenda ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package worf
  :ensure t
  :config
  (add-hook 'org-mode-hook 'worf-mode)
  (define-key worf-mode-map (kbd "[") nil)
  (define-key worf-mode-map (kbd "]") nil))

(use-package org-alert
  :ensure t)

;; The following code only shows the first action to be done per heading
;; This code is taken more or less verbatim from the emacs.cafe article above.
(defun jws/org-current-is-todo ()
  (string= "TODO" (org-get-todo-state)))

(defun jws/org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry."
  (let (should-skip-entry)
    (unless (jws/org-current-is-todo)
      (setq should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
        (when (jws/org-current-is-todo)
          (setq should-skip-entry t))))
    (when should-skip-entry
      (or (outline-next-heading)
          (goto-char (point-max))))))
;; end snippet

(setq org-log-done t
      org-refile-targets '((nil . (:maxlevel . 9))
                           (org-agenda-files . (:maxlevel . 9)))
      org-refile-use-outline-path t
      org-outline-path-complete-in-steps nil
      org-archive-location "finished.org::datetree/*"
      org-agenda-span 14
      org-use-fast-todo-selection t
      org-log-into-drawer t
      org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)"))
      org-tag-alist '(("@personal" . ?p) ("@career" . ?c) ("@errand" . ?e) ("@travel" . ?t))
      org-agenda-custom-commands
      '(("p" "Personal" tags-todo "@personal"
         ((org-agenda-overriding-header "Personal")
          (org-agenda-skip-function #'jws/org-agenda-skip-all-siblings-but-first)))
        ("c" "Career" tags-todo "@career"
         ((org-agenda-overriding-header "Career")
          (org-agenda-skip-function #'jws/org-agenda-skip-all-siblings-but-first)))
        ("E" "Errands" tags-todo "@errand"
         ((org-agenda-overriding-header "Errands")
          (org-agenda-skip-function #'jws/org-agenda-skip-all-siblings-but-first)))
        ("A" "Travel" tags-todo "@travel"
         ((org-agenda-overriding-header "Travelling")
          (org-agenda-skip-function #'jws/org-agenda-skip-all-siblings-but-first)))))

(setq jws/agenda-files
      '("inbox.org" "gtd.org" "tickler.org" "recurring.org"))

(defun jws/load-org-settings ()
  "Run this after changing jws/org*dir."
  (interactive)
  (setq org-default-notes-file (concat jws/org-dir "notes.org")
        org-agenda-files (seq-filter
                          #'file-exists-p
                          (mapcar
                           (lambda (f) (concat jws/org-agenda-dir f))
                           jws/agenda-files)))
  (message "jws/agenda-files: %S" jws/agenda-files)
  (message "org-agenda-files: %S" org-agenda-files))

(if (and (file-exists-p jws/org-dir) (file-exists-p jws/org-agenda-dir))
    (progn
      (jws/load-org-settings))
  (message "Please set up jws/org-dir and jws/org-agenda-dir to use org-agenda, etc."))

(after 'org-agenda
  ;; Enabling vim bindings in the agenda
  (evil-add-hjkl-bindings org-agenda-mode-map 'emacs)
  (define-key org-agenda-mode-map (kbd "L") 'org-agenda-log-mode)
  (define-key org-agenda-mode-map (kbd "C") 'org-agenda-capture)
  (define-key org-agenda-mode-map (kbd "d") 'org-agenda-goto-date))

;; Save after various edits in org-mode/org-agenda
(advice-add 'org-deadline :after 'org-save-all-org-buffers)
(advice-add 'org-refile :after 'org-save-all-org-buffers)

(defun jws/show-org-agenda ()
  "Run `org-agenda' and bring its buffer to the front.

I like to `setq' the `initial-buffer-choice' to this function
in my site-init.el.  This displays the `org-agenda' at startup."
  (interactive)
  (org-agenda-list)
  (get-buffer "*Org Agenda*"))

;; org-capture ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; http://orgmode.org/manual/Capture-templates.html
(setq org-capture-templates
      '(("t" "Todo" entry (file (lambda () (concat jws/org-agenda-dir "inbox.org")))
         "* TODO %?\n  %i")
        ("T" "Tickler" entry (file (lambda () (concat jws/org-agenda-dir "tickler.org")))
         "* TODO %i%?\n  %T")
        ("l" "Link" entry (file+headline (lambda () (concat jws/org-dir "links.org")) "Uncategorized")
         "* %?")
        ("j" "Journal" entry (file+datetree (lambda () (concat jws/org-journal-dir (format-time-string "%Y") ".org")))
         "* %?\n  Entered on %U\n  %i")
        ("s" "Shopping list" entry (file+headline (lambda () (concat jws/org-dir "shopping.org")) "Unfiled Shopping")
         "* %?\n  Entered on %U\n  %i")))

;; note-taking (deft) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package deft
  :ensure t
  :commands (deft)
  :config
  (setq deft-directory jws/org-notes-dir
        deft-extensions '("org" "md" "markdown" "txt")
        deft-default-extension "org"
        deft-use-filename-as-title nil
        deft-use-filter-string-for-filename t
        deft-file-naming-rules
        '((noslash . "-")
          (nospace . "-")
          (case-fn . downcase))))

;; keybindings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun jws/open-org-dir ()
  (interactive)
  (counsel-find-file jws/org-dir))

(define-key evil-normal-state-map (kbd "<f5>") 'org-agenda)
(define-key evil-normal-state-map (kbd "<f6>") 'deft)

(define-key jws/leader-map (kbd "f o") 'jws/open-org-dir)
(define-key jws/leader-map (kbd "f n") 'deft)

(jws/after (hydra)
  (defhydra jws/hydra-org (:exit t)
    ("r" jws/load-org-settings "Load org settings")
    ("l" org-store-link "Store link")
    ("a" org-agenda "Agenda")
    ("c" org-capture "Capture")
    ("e" org-export "Export")
    ("n" deft "Notes"))

  (global-set-key (kbd "M-j o") 'jws/hydra-org/body)
  (jws/after (evil)
    (define-key evil-normal-state-map (kbd "SPC o") 'jws/hydra-org/body)))

(provide 'jws-org-mode)

;;; jws-org-mode.el ends here
