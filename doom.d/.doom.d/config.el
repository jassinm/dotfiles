;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jassin Meknassi"
      user-mail-address "jassinm@pm.me")

(require 'disp-table)
(require 'nano-faces)
(require 'nano-theme)
(require 'nano-writer)
(require 'nano-base-colors)
(require 'nano-theme-light)
(require 'nano-theme-dark)
(require 'nano-help)
(require 'nano-modeline)
(require 'nano-layout)
;;jassinm
(load "~/.doom.d/org-webkit-preview.el")
;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
 ;; (setq doom-font (font-spec :family "PragmataPro" :size 15)
 ;;       doom-big-font (font-spec :family "PragmataPro" :size 18))
 ;;(setq doom-font (font-spec :family "Roboto Mono" :size 15)
;;       doom-big-font (font-spec :family "Roboto Mono" :size 18))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'leuven)
(setq doom-theme 'leuven)
;;(setq doom-theme 'doom-gruvbox)
(setq doom-gruvbox-dark-variant "hard")
(setq display-line-numbers-type t)
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;;org

(setenv "PATH" (concat ":/Library/TeX/texbin/" (getenv "PATH")))
(add-to-list 'exec-path "/Library/TeX/texbin/")

(map! :leader
      "c l" #'comment-or-uncomment-region)

(setq org-roam-directory "~/Dropbox (Personal)/org/roam")
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(after! org
  (map! :map org-mode-map
        :n "M-j" #'org-metadown
        :n "M-k" #'org-metaup)
  (map! :leader
        "n p" #'org-webkit-preview/org-preview-html)
  (setq
        org-directory "~/Dropbox (Personal)/org"
        org-agenda-files (concat org-directory "notes")
        org-planning-line-re ""
        org-src-fontify-natively t
        org-latex-create-formula-image-program 'dvisvgm
        org-preview-latex-image-directory "./tex.preview/"
        ;;babel
        org-confirm-babel-evaluate nil
        ;; org-ref
        ;reftex-default-bibliography '("~/Dropbox (Personal)/bibliography/references.bib")
        ;org-ref-bibliography-notes '("~/Dropbox (Personal)/bibliography/notes.org")
        ;org-ref-default-bibliography '("~/Dropbox (Personal)/bibliography/references.bib")
        ;org-ref-pdf-directory '("~/Dropbox (Personal)/bibliography/bibtex-pdfs/")

        org-capture-templates `(
                ("p" "Protocol" entry (file+headline ,(concat org-directory "notes.org") "Inbox")
                "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
                ("L" "Protocol Link" entry (file+headline ,(concat org-directory "notes.org") "Inbox")
                 "* %? [[%:link][%:description]] \nCaptured On: %U"))
   )
)

(after! deft
  (setq
        deft-directory "~/Dropbox (Personal)/org"
        deft-extension '("org" "mdown")
        deft-recursive t))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(toggle-frame-maximized)
;; (toggle-frame-fullscreen)
(defun nano-theme-light ()
  "Enable dark Nano theme and customizations."
  (interactive)
  (nano-theme-set-light)
  (setq nano-color-popout "#FF7B52")
  (nano-faces)
  (nano-theme)
  (set-face-attribute 'bold nil :weight 'bold)
  ;;(set-cursor-color "#ffffff")
 )

(defun nano-theme-dark()
  "Enable dark Nano theme and customizations."
  (interactive)
  (nano-theme-set-dark)
  (nano-faces)
  (nano-theme)
 )

(nano-theme-light)
;;(nano-defaults)

;; (setq doom-font (font-spec :family "PragmataPro" :size 15)
;;       doom-big-font (font-spec :family "PragmataPro" :size 18))
