(require 'w3m-load)

;; change default browser for 'browse-url' to w3m
(setq browse-url-browser-function 'w3m-goto-url-new-session)

;; display images by default
(setq w3m-default-display-inline-images t)

;; vimperator/conkeror-style navigation
(w3m-lnum-mode 1)

;; change w3m user-agent to android
(setq w3m-user-agent "Mozilla/5.0 (Linux; U; Android 2.3.3; en-us; HTC_Pyramid Build/GRI40) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.")

(provide 'init-w3m)
