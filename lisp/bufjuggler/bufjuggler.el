;; Code is cribbed from https://github.com/abo-abo/hydra/wiki/Switch-to-buffer
;; and then edited somewhat to make it work more like the Vim plugin
;; "LustyJuggler": http://www.vim.org/scripts/script.php?script_id=2050
;; That plugin provided the 10 most MRU buffers and put them on asdfghjkl;
;; and on 1234567890.

;; Right now, this code isn't really good enough to be "its own library" but
;; I may at some point extract it and polish it up to do so...

;; FIXME: extract this code and put it in its own library
;; FIXME: add a proper keybinding, rather than forcing one on the user
;; FIXME: make it so that users can use Dvorak, etc instead of qwerty
;;        home row
;; FIXME: fix formatting of hydra docstring so everything is in nice neat
;;        columns (or just replace hydra)
;; FIXME: fix 'nil' when there are less than ten open buffers

(defun bufj/name-of-buffers (n)
  "Return the names of the first N buffers from `buffer-list'."
  (let ((bns
         (delq nil
               (mapcar
                (lambda (b)
                  (unless (string-match "^ " (setq b (buffer-name b)))
                    b))
                (buffer-list)))))
    (subseq bns 1 (min (1+ n) (length bns)))))

(defvar bufj/last-buffers nil)

(defun bufj/switch-to-buffer (arg)
  (interactive "p")
  (switch-to-buffer
   (bufj/name-of-buffer arg)))

(defun bufj/name-of-buffer (arg)
  (nth (1- arg) bufj/last-buffers))

(defhydra bufj/hydra (:exit t :hint nil :body-pre (setq bufj/last-buffers
                                                        (bufj/name-of-buffers 10)))
  "
The Amazing BufJuggler:
------------------------
_a_,_1_: %s(bufj/name-of-buffer 1)  _s_,_2_: %s(bufj/name-of-buffer 2)  _d_,_3_: %s(bufj/name-of-buffer 3)  _f_,_4_: %s(bufj/name-of-buffer 4)  _g_,_5_: %s(bufj/name-of-buffer 5)
_h_,_6_: %s(bufj/name-of-buffer 6)  _j_,_7_: %s(bufj/name-of-buffer 7)  _k_,_8_: %s(bufj/name-of-buffer 8)  _l_,_9_: %s(bufj/name-of-buffer 9)  _;_,_0_: %s(bufj/name-of-buffer 10)
"

  ("1" (bufj/switch-to-buffer 1))
  ("2" (bufj/switch-to-buffer 2))
  ("3" (bufj/switch-to-buffer 3))
  ("4" (bufj/switch-to-buffer 4))
  ("5" (bufj/switch-to-buffer 5))
  ("6" (bufj/switch-to-buffer 6))
  ("7" (bufj/switch-to-buffer 7))
  ("8" (bufj/switch-to-buffer 8))
  ("9" (bufj/switch-to-buffer 9))
  ("0" (bufj/switch-to-buffer 10))
  
  ("a" (bufj/switch-to-buffer 1))
  ("s" (bufj/switch-to-buffer 2))
  ("d" (bufj/switch-to-buffer 3))
  ("f" (bufj/switch-to-buffer 4))
  ("g" (bufj/switch-to-buffer 5))
  ("h" (bufj/switch-to-buffer 6))
  ("j" (bufj/switch-to-buffer 7))
  ("k" (bufj/switch-to-buffer 8))
  ("l" (bufj/switch-to-buffer 9))
  (";" (bufj/switch-to-buffer 10))
  
  ("<escape>" nil))

(defun bufj/uggler ()
  (interactive)
  (bufj/hydra/body))

(provide 'bufj)

;;; bufjuggler.el ends here
