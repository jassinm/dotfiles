(setq-default
    dotspacemacs-themes '(leuven solarized-light monokai)
    dotspacemacs-configuration-layers '(osx loco python ess auto-completion)
    dotspacemacs-leader-key ","
    dotspacemacs-default-font '("PragmataPro"
                                :size 15
                                :weight normal
                                :width normal
                                :powerline-scale 1.1)
)
(defun dotspacemacs/init ()
  "User initialization for Spacemacs. This function is called at the very
 startup."
  (setq org-agenda-files '("~/.org"))
  (setq org-src-fontify-natively t)
  (setq org-src-preserve-indentation t)
  (setq org-src-tab-acts-natively t)
  (setq org-babel-python-command "ipython --no-banner --classic --no-confirm-exit --pprint")

  (setq python-indent-guess-indent-offset nil)

  (setq-default evil-escape-delay 0.2)
  (setq-default evil-escape-key-sequence "jj")
  ;;(evil-leader/set-key "d" 'neotree-toggle)
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
  (add-hook 'org-mode-hook 'org-display-inline-images)
)

(defun dotspacemacs/config ()
  "This is were you can ultimately override default Spacemacs configuration.
This function is called at the very end of Spacemacs initialization."
  ;;(setq evil-leader/leader ",")
  (setq powerline-default-separator 'arrow)
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
