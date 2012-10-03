(require 'package)
(add-to-list 'package-archives
                 '("marmalade" .
                         "http://marmalade-repo.org/packages/"))
(package-initialize)

(require 'evil)
(evil-mode 1)


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

(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)
