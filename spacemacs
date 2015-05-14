(defun dotspacemacs/layers ()
  "Configuration Layers declaration."
  (setq-default
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (ie. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     ;; --------------------------------------------------------
     ;; Example of useful layers you may want to use right away
     ;; Uncomment a layer name and press C-c C-c to install it
     ;; --------------------------------------------------------
     ;; auto-completion
     ;; better-defaults
     ;; (git :variables
     ;;      git-gutter-use-fringe t)
     ;; markdown
     ;; org
     ;; syntax-checking
     osx
     loco
     python
     ess
     auto-completion
     syntax-checking
     org
     dash
     )
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration."

  (setq-default
    dotspacemacs-themes '(leuven
                          monokai
                          badwolf)

    dotspacemacs-leader-key ","
    dotspacemacs-editing-style 'vim
    dotspacemacs-default-font '("PragmataPro"
                                :size 15
                                :weight normal
                                :width normal
                                :powerline-scale 1.1)
    evil-escape-delay 0.2
    evil-escape-key-sequence "jj")

  (setq org-agenda-files '("~/.org"))
  (setq org-src-fontify-natively t)
  (setq org-src-preserve-indentation t)
  (setq org-src-tab-acts-natively t)
  (setq org-babel-python-command "ipython --no-banner --classic --no-confirm-exit --pprint")

  (setq linum-format "%4d \u2502 ")

  (setq python-indent-guess-indent-offset nil)
  ;;(evil-leader/set-key "d" 'neotree-toggle)
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
  ;;(add-hook 'org-mode-hook 'org-display-inline-images)
  (add-hook 'org-mode-hook (lambda ()
                             ;;(setq buffer-face-mode-face '(:family "Inconsolata"))
                             (setq buffer-face-mode-face '(:family "Source Code Pro"))
                             (buffer-face-mode)
                             ('org-display-inline-images)))
  (add-to-list 'custom-theme-load-path "~/.emacs.d/private/themes")
)

(defun dotspacemacs/config ()
  "This is were you can ultimately override default Spacemacs configuration.
This function is called at the very end of Spacemacs initialization."
  ;;(setq evil-leader/leader ",")
  (setq powerline-default-separator 'arrow)
  ;;(define-key evil-motion-state-local-map (kbd "o") 'spacemacs/neotree-expand-or-open)
  (evil-define-key 'motion neotree-mode-map  (kbd "o") 'neotree-enter)
  (evil-define-key 'motion neotree-mode-map  (kbd "r") 'neotree-refresh)
  ;;(add-to-hooks 'linum-mode '(python-mode-hook))
  ;;
  (setq multi-term-program "/usr/local/bin/zsh")
  ;;(setq system-uses-terminfo nil)
  (evil-leader/set-key "," 'helm-find-files)

)


(custom-set-variables
 '(org-babel-load-languages (quote ((emacs-lisp . t)
                                    (sh . t)
                                    (python . t)
                                    (sql . t)
                                    (R . t)))))

;; use %cpaste to paste code into ipython in org mode
(defadvice org-babel-python-evaluate-session
  (around org-python-use-cpaste
          (session body &optional result-type result-params) activate)
  "Add a %cpaste and '--' to the body, so that ipython does the right
thing."
  (setq body (concat "%cpaste -q\n" body "\n--"))
  ad-do-it
  ad-return-value)

(defun org-babel-execute:panda (body params)
  (let ((results
          (org-babel-execute:python
          body (org-babel-merge-params '((:results . "scalar")) params))))
    (org-babel-result-cond (cdr (assoc :result-params params))
      results
      (let ((tmp-file (org-babel-temp-file "sh-")))
        (with-temp-file tmp-file (insert results))
        (org-babel-import-elisp-from-file tmp-file)))))
