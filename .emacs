(add-to-list 'load-path "~/.emacs.d")

(require 'package)

(setq package-archives
            '(("gnu" . "http://elpa.gnu.org/packages/")
              ("marmalade" . "http://marmalade-repo.org/packages/")
                      ("melpa" . "http://melpa.milkbox.net/packages/")))
(defun loco-install-packages ()
  "Install some handy packages from marmalade."
  (interactive)
  (package-initialize)
  (package-refresh-contents)
  (dolist (p '(starter-kit
           starter-kit-lisp
           auto-complete
           clojure-mode
           clojure-project-mode
           evil
           nrepl
           ac-nrepl
           rainbow-delimiters
           mic-paren
           monokai-theme
           solarized-theme
           ein
           nav
           python-mode
           virtualenv
           pymacs
           nose
           jinja2-mode
           flymake-python-pyflakes
           highlight-identation
           yasnippet-bundle
           magit
           rainbow-mode
           ack
           gist))
    (when (not (package-installed-p p))
      (package-install p))))
(package-initialize)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; nav
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'nav)
(nav-disable-overeager-window-splitting)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; autocomplete
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'auto-complete-config)
(ac-config-default)
;; start completing after 1 char
(setq ac-auto-start 1)
;;(setq ac-ignore-case t)

(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
;;(require 'ac-anything)
;;ac-source-filename
(global-set-key (kbd "C-c /") 'ac-complete-filename)
;;
;;(set-face-background 'ac-candidate-face "#998f84")
;;(set-face-background 'ac-selection-face "#ffa724")
;;(set-face-foreground 'ac-selection-face "#000000")



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; look-good
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; theme
(add-to-list 'custom-theme-load-path "/Users/locojay/.emacs.d/themes")
(set-cursor-color "#0a9dff")
(provide 'init-themes)
;;(load-theme 'monokai t)
;;(setq solarized-termcolors 256)
;;(load-theme 'solarized-light t)
(load-theme 'badwolf t)

(set-default-font "PragmataPro-15")

(setq frame-title-format '("Emacs @ " system-name ": %b %+%+ %f"))
(setq idle-highlight-global-timer 1)
(set-fringe-mode 0)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; config's
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;show line numbers
(global-linum-mode t)
(setq linum-format "%d ")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; matching parens
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; highlight matching parens
(require 'mic-paren)
(paren-activate)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rainbow-delimiters
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; clojure project-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'clojure-project-mode)
(project-load-all)
(project-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; clojure-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'paredit) if you didn't install via package.el
(defun turn-on-paredit () (paredit-mode 1))
(add-hook 'clojure-mode-hook 'turn-on-paredit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; nrepl
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq nrepl-lein-command "/Users/locojay/bin/lein2")
(add-hook 'nrepl-interaction-mode-hook
  'nrepl-turn-on-eldoc-mode)
(setq nrepl-popup-stacktraces nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ac-nrepl
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ac-nrepl)
 (add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
 (add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
 (eval-after-load "auto-complete"
   '(add-to-list 'ac-modes 'nrepl-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rainbow-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'rainbow-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ein
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'ein)
(setq ein:use-auto-complete t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; evil mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'evil)
(evil-mode 1)
;; map jj to esc
(define-key evil-insert-state-map "j" #'cofi/maybe-exit)

(evil-define-command cofi/maybe-exit ()
  :repeat change
  (interactive)
  (let ((modified (buffer-modified-p)))
    (insert "j")
    (let ((evt (read-event (format "Insert %c to exit insert state" ?j)
               nil 0.5)))
      (cond
       ((null evt) (message ""))
       ((and (integerp evt) (char-equal evt ?j))
    (delete-char -1)
    (set-buffer-modified-p modified)
    (push 'escape unread-command-events))
       (t (setq unread-command-events (append unread-command-events
                          (list evt))))))))

(define-key evil-normal-state-map ",d" 'nav-toggle)
(define-key evil-normal-state-map ",f" 'ns-toggle-fullscreen)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; buffer-file stuff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; editing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default indent-tabs-mode nil)    ; use only spaces and no tabs
(setq default-tab-width 4)
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; global
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; prevent beep
(setq visible-bell t)
;;follow symlinks and don't ask
(setq vc-follow-symlinks t)
;;save position in files
(setq-default save-place t)


;;(setq backup-directory-alist '("." . "~/.emacs.d/backups"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; python
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'python-mode)
(require 'flymake-python-pyflakes)
(require 'ac-python)


(setq flymake-python-pyflakes-executable "/usr/local/share/python/pyflakes")
(add-hook 'python-mode-hook
          (lambda ()
            ;;(fci-mode t)
            (flymake-python-pyflakes-load)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yasnippet
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'yasnippet-bundle)
(yas/initialize)
(yas/load-directory "~/.emacs.d/my-snippets/")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ack
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'ack)
(setq ack-command "/usr/local/bin/ack")
