(require 'package)
(add-to-list 'package-archives
                 '("marmalade" .
                         "http://marmalade-repo.org/packages/"))
(package-initialize)

;; clojure
;; (require 'paredit) if you didn't install via package.el
(defun turn-on-paredit () (paredit-mode 1))
(add-hook 'clojure-mode-hook 'turn-on-paredit)

(require 'evil)
(evil-mode 1)

(require 'highlight-parentheses)

;; nrepl
(setq nrepl-lein-command "/Users/locojay/bin/lein2")
(add-hook 'nrepl-interaction-mode-hook
  'nrepl-turn-on-eldoc-mode)
(setq nrepl-popup-stacktraces nil)



; make "jk" behave as ESC key
(defun escape-if-next-char (c)
    "Watches the next letter.  If c, then switch to viper mode, otherwise insert a j and forward unpressed key to unread-command-events"
      (self-insert-command 1)
        (let ((next-key (read-event)))
              (if (= c next-key)
                        (progn
                                    (delete-backward-char 1)
                                              (viper-mode))
                              (setq unread-command-events (list next-key)))))

(defun escape-if-next-char-is-k (arg)
    (interactive "p")
      (if (= arg 1)
              (escape-if-next-char ?k)
                  (self-insert-command arg)))

(define-key evil-insert-state-map (kbd "j") 'escape-if-next-char-is-k)
(put 'downcase-region 'disabled nil)


(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)

