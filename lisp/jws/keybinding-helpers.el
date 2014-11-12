;; Functions intended to be mapped to keys.  Some are intended to
;; help improve the "Vim-iness" of my setup, some are helpers.

;; Quit recursive edit; used to make the Escape key work like in Vim
; from https://github.com/davvil/.emacs.d/blob/master/init.el
(defun jws/minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

;; Switches to the previous buffer without prompting or anything.
;; I've always mapped this to <leader>j -- Vim also puts this on
;; C-6 but I stopped using that binding a while before I even took
;; emacs back up.
(defun jws/switch-to-previous-buffer ()
  "Switches to the previous buffer."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer))))

(provide 'jws/keybinding-helpers)
