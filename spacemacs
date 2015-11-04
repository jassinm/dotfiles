(defun dotspacemacs/layers ()
  "Configuration Layers declaration."
  (setq-default
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (ie. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-additional-packages '(ob-ipython gruvbox-theme)
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     ;; --------------------------------------------------------
     ;; Example of useful layers you may want to use right away
     ;; Uncomment a layer name and press C-c C-c to install it
     ;; --------------------------------------------------------
     ;; better-defaults
     (git :variables
          git-gutter-use-fringe t)
     auto-completion
     osx
     loco
     python
     ipython-notebook
     (ess :variables ess-enable-smart-equals t)
     syntax-checking
     org
     pandoc
     dash
     ;;(shell :variables shell-default-term-shell '/usr/local/bin/zsh)
     (shell :variables shell-default-shell 'eshell)
     eyebrowse
     semantic
     smex
     gtags
     ranger
     theming
     (c-c++ :variables c-c++-enable-clang-support t)
     )
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'
   dotspacemacs-delete-orphan-packages t
   ))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration."

  (setq-default
   dotspacemacs-leader-key "SPC"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-command-key ":"
   dotspacemacs-editing-style 'vim

   dotspacemacs-startup-banner nil
   dotspacemacs-maximized-at-startup t


   dotspacemacs-themes '(gruvbox
                         spacemacs-light
                         monokai
                         leuven
                         )

    dotspacemacs-startup-lists '(recents bookmarks projects)

    dotspacemacs-default-font '("PragmataPro"
                                :size 15
                                :weight normal
                                :width normal
                                :powerline-scale 1.1)
    dotspacemacs-search-tools '("ag" "pt" "ack" "grep"))
    dotspacemacs-mode-line-unicode-symbols nil

)

(defun dotspacemacs/user-init ()
  (setq-default
   evil-escape-key-sequence "jk"
   evil-escape-delay 0.2

   evil-shift-round nil

   ;; Miscellaneous
   vc-follow-symlinks t

   ;; Whitespace mode
   whitespace-style '(face tabs tab-mark)
   whitespace-display-mappings
   '((newline-mark 10 [172 10])
     (tab-mark 9 [9655 9]))

   ;; Ranger
   ranger-override-dired t
   ranger-show-dotfiles t
   ranger-ignored-extensions '("mkv" "iso" "mp4" "mp3")


   ;; Org
   org-agenda-files '("~/.org")
   org-planning-line-re ""
   org-src-fontify-natively t
   org-src-preserve-indentation t
   org-src-tab-acts-natively t
   ;don't prompt me to confirm everytime I want to evaluate a block
   org-confirm-babel-evaluate nil
   org-babel-python-command "ipython --no-banner --classic --no-confirm-exit --pprint"
   org-babel-load-languages '((emacs-lisp . t)
                              (lisp . t)
                              (R . t)
                              (sql . t)
                              (ipython . t)
                              (python . t))

   ;; don't evaluate babel code when publishing
   org-export-babel-evaluate nil
   org-src-fontify-natively t

   theming-modifications
   '((monokai
      ;;babel
      ;;(clock-line '(:box (:line-width 1 :color "#335EA8") :foreground "black" :background "#EEC900"))
      ;;(code-block '(:foreground "#000088" :background "#FFFFE0"))
      ;;(code-inline '(:foreground "#006400" :background "#FDFFF7"))
      ;;(org-code ((,class ,code-inline)))
      (org-code :foreground "#00088")
      ))

   )
)

(defun my-common-hook ()
  (linum-mode 1)
  )

(defun dotspacemacs/user-config ()
  "This is were you can ultimately override default Spacemacs configuration.
This function is called at the very end of Spacemacs initialization."

  ;; Miscellaneous
  (add-hook 'text-mode-hook 'auto-fill-mode)
  (add-hook 'makefile-mode-hook 'whitespace-mode)


  ;; Org
  (add-hook 'org-mode-hook (lambda ()
                             (buffer-face-mode)
                             (org-display-inline-images)))

  ;; Some fixes for comint-style buffers
  (let ((comint-hooks '(eshell-mode-hook
                        term-mode-hook
                        erc-mode-hook
                        messages-buffer-mode-hook
                        comint-mode-hook)))
    (spacemacs/add-to-hooks (defun bb/no-hl-line-mode ()
                              (setq-local global-hl-line-mode nil))
                            comint-hooks)
    (spacemacs/add-to-hooks (defun bb/no-scroll-margin ()
                              (setq-local scroll-margin 0))
                            comint-hooks))

  (setq powerline-default-separator 'arrow)
  (evil-define-key 'motion neotree-mode-map  (kbd "o") 'neotree-enter)
  (evil-define-key 'motion neotree-mode-map  (kbd "r") 'neotree-refresh)

  (add-hook 'python-mode-hook
            'my-common-hook
            ( lambda ()
              (setq python-shell-interpreter "python")
               setq anaconda-mode-server-script
               "/usr/local/lib/python2.7/site-packages/anaconda_mode.py")
            (setq python-indent-guess-indent-offset nil))

  (add-hook 'R-mode-hook 'my-common-hook)
  (add-hook 'sql-mode-hook 'my-common-hook)

  ;;(setq multi-term-program "/usr/local/bin/zsh")

  ;;(evil-leader/set-key "," 'helm-find-files)

  (setq linum-format "%4d \u2502 ")


  (add-to-list 'custom-theme-load-path "~/.emacs.d/private/themes")

)
