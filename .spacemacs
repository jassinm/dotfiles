(setq-default
    dotspacemacs-configuration-layers '(osx loco)
)
(defun dotspacemacs/init ()
  "User initialization for Spacemacs. This function is called at the very
 startup."
  (setq org-agenda-files '("~/.org"))

  (setq-default evil-escape-delay 0.2)
  (setq-default evil-escape-key-sequence "jj")
)

(defun dotspacemacs/config ()
  "This is were you can ultimately override default Spacemacs configuration.
This function is called at the very end of Spacemacs initialization."
  (setq evil-leader/leader ",")
  (setq powerline-default-separator 'arrow)
)

