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
           nav
           magit
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; look-good
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; theme
(add-to-list 'custom-theme-load-path "/Users/locojay/.emacs.d/themes")
(provide 'init-themes)
;;(load-theme 'monokai t)
(setq solarized-termcolors 256)
(load-theme 'solarized-light t)

(set-default-font "PragmataPro-15")

;;(add-to-list 'default-frame-alist '(background-mode . dark))
;;(load-theme 'tango-dark t)
(setq frame-title-format '("Emacs @ " system-name ": %b %+%+ %f"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; config's
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;show line numbers
(global-linum-mode t)

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("27713778ce0291c1002fac10ba08f6de8430a6f24a506b821293b9eda806dfcc" "2a962c80c1d40251389b1f3a7d5508e5f866529c58cb9f3363d7c177672dac9a" "1cd4f389c2e67204c96b3e9a28d4fa4674e57d7532808614499f0950dd381c49" "0a7de097291a69f8ff04c3b6f126166ba895b2f08e755d75012b12253e390283" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
