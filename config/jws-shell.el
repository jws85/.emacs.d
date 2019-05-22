;; shell-mode ----------------------------------------------------------------

;; Disable company-mode in shell, to prevent needing to hit RET twice
(defun jws/disable-completion-in-shell ()
  (company-mode -1)
  (setq-local company-mode nil))
(add-hook 'shell-mode-hook #'jws/disable-completion-in-shell)
(add-hook 'eshell-mode-hook #'jws/disable-completion-in-shell)

;; eshell-mode ---------------------------------------------------------------

;; Turn off eshell-prefer-lisp-functions to prefer the Unix version of
;; commands like find and chmod, if they exist
(setq eshell-scroll-to-bottom-on-input 'all
      eshell-error-if-no-glob t
      eshell-hist-ignoredups t
      eshell-save-history-on-exit t
      eshell-prefer-lisp-functions nil
      eshell-destroy-buffer-when-process-dies t)

;; Commands to run in ansi-term instead of eshell
(add-hook 'eshell-mode-hook
          (lambda ()
            (add-to-list 'eshell-visual-commands "htop")
            (add-to-list 'eshell-visual-commands "ranger")))

;; eshell management - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

;; From http://www.howardism.org/Technical/Emacs/eshell-fun.html
(defun jws/eshell-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))))

(defun eshell/x ()
  (insert "exit")
  (eshell-send-input)
  (delete-window))

;; eshell prompt - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;; I grabbed most of the code from here:
;; https://github.com/howardabrams/dot-files/blob/master/emacs-eshell.org#special-prompt
;; but then I edited heavily to remove some of the eye candy.
(defun jws/curr-dir-git-branch-string (pwd)
  "Returns current git branch as a string, or the empty string if
PWD is not in a git repo (or the git command is not found)."
  (interactive)
  (when (and (not (file-remote-p pwd))
             (eshell-search-path "git")
             (locate-dominating-file pwd ".git"))
    (let* ((git-output (shell-command-to-string (concat "git rev-parse --abbrev-ref HEAD"))))
      (concat "git:" (s-trim git-output)))))

(defun jws/pwd-replace-home (pwd)
  "Replace home in PWD with tilde (~) character."
  (interactive)
  (let* ((home (expand-file-name (getenv "HOME")))
         (home-len (length home)))
    (if (and
         (>= (length pwd) home-len)
         (equal home (substring pwd 0 home-len)))
        (concat "~" (substring pwd home-len))
      pwd)))

(defun jws/pwd-shorten-dirs (pwd)
  "Shorten all directory names in PWD except the last two."
  (let ((p-lst (split-string pwd "/")))
    (if (> (length p-lst) 2)
        (concat
         (mapconcat (lambda (elm) (if (zerop (length elm)) "")
                               (substring elm 0 1))
                    (butlast p-lst 2)
                    "/")
         "/"
         (mapconcat (lambda (elm) elm)
                    (last p-lst 2)
                    "/"))
      pwd)))  ;; Otherwise, we just return the PWD

(defun jws/split-directory-prompt (directory)
  (if (string-match-p ".*/.*" directory)
      (list (file-name-directory directory) (file-name-base directory))
    (list "" directory)))

(defun jws/ruby-prompt ()
  "Returns a string (may be empty) based on the current Ruby Virtual Environment."
  (let* ((executable "~/.rvm/bin/rvm-prompt")
         (command    (concat executable "v g")))
    (when (file-exists-p executable)
      (let* ((results (shell-command-to-string executable))
             (cleaned (string-trim results)))
        (when (and cleaned (not (equal cleaned "")))
          cleaned)))))

(defun jws/python-prompt ()
  "Returns a string (may be empty) based on the current Python
   Virtual Environment. Assuming the M-x command: `pyenv-mode-set'
   has been called."
  (when (fboundp #'pyenv-mode-version)
    (let ((venv (pyenv-mode-version)))
      (when venv
        (pyenv-mode-version)))))

(defun jws/eshell-local-prompt-function ()
  "A prompt for eshell that works locally (in that is assumes
that it could run certain commands) in order to make a prettier,
more-helpful local prompt."
  (interactive)
  (let* ((pwd        (eshell/pwd))
         (directory (jws/split-directory-prompt
                     (jws/pwd-shorten-dirs
                      (jws/pwd-replace-home pwd))))
         (parent (car directory))
         (name   (cadr directory))
         (branch (jws/curr-dir-git-branch-string pwd))
         (ruby   (when (not (file-remote-p pwd)) (jws/ruby-prompt)))
         (python (when (not (file-remote-p pwd)) (jws/python-prompt)))

         (dark-env (eq 'dark (frame-parameter nil 'background-mode)))
         (for-bars                 `(:weight bold))
         (for-parent  (if dark-env `(:foreground "dark orange") `(:foreground "blue")))
         (for-dir     (if dark-env `(:foreground "orange" :weight bold)
                        `(:foreground "blue" :weight bold)))
         (for-git                  `(:foreground "green"))
         (for-ruby                 `(:foreground "red"))
         (for-python               `(:foreground "#5555FF")))

    (concat
     (propertize parent   'face for-parent)
     (propertize name     'face for-dir)
     (when branch
       (concat " " (propertize branch 'face for-git)))
     (when ruby
       (concat " " (propertize ruby 'face for-ruby)))
     (when python
       (concat " " (propertize python 'face for-python)))
     (propertize "\n"     'face for-bars)
     (propertize (if (= (user-uid) 0) "#" "$") 'face `(:weight ultra-bold))
     (propertize " "    'face `(:weight bold)))))

(setq-default eshell-prompt-function #'jws/eshell-local-prompt-function)

;; The eshell-prompt-regexp must match eshell-prompt-function
;; Or else lots of stuff will be sideways, not least of which
;; would be completion not working... >_<
(setq eshell-prompt-regexp "^[^#$\n]*[#$] "
      eshell-highlight-prompt nil)

(use-package eshell-bookmark
  :ensure t
  :config
  (add-hook 'eshell-mode-hook 'eshell-bookmark-setup))

;; (ansi-)term-mode ----------------------------------------------------------

;; Close the ansi-term buffer when finished
(defun jws/oleh-term-exec-hook ()
  "Copied from https://oremacs.com/2015/01/01/three-ansi-term-tips/"
  (let* ((buff (current-buffer))
         (proc (get-buffer-process buff)))
    (set-process-sentinel
     proc
     `(lambda (process event)
        (if (string= event "finished\n")
            (kill-buffer ,buff))))))
(add-hook 'term-exec-hook 'jws/oleh-term-exec-hook)

;; Open up shell through shortcut
(defun jws/ansi-term-zsh ()
  (interactive)
  (split-window-sensibly)
  (ansi-term "/bin/zsh"))

(eval-after-load "term"
  '(define-key term-raw-map (kbd "M-j") nil))

;; Keybindings ---------------------------------------------------------------

(define-key jws/leader-map (kbd "x e") 'jws/eshell-here)
(define-key jws/leader-map (kbd "x t") 'jws/ansi-term-zsh)

(provide 'jws-shell)
