;;; org-webkit-preview.el -*- lexical-binding: t; -*-
(require 'org)
(require 'xwidget)


(defvar-local preview-file nil)

(defun pandoc-href-from-val (val)
  (downcase
   (replace-regexp-in-string "['/\(\)]" ""
        (replace-regexp-in-string " " "-" val))
   ))

(defun get-orgfile-title (file)
  ;; source https://emacs.stackexchange.com/questions/27620/orgmode-capturing-original-document-title
  (let (title)
    (when file
      (with-current-buffer
          (get-file-buffer file)
        (pcase (org-collect-keywords '("TITLE"))
          (`(("TITLE" . ,val))
           (setq title (car val)))))
      title)))

(defcustom convert-command "./convert_note_file.sh"
  "define the command to convert org to html"
  :type 'string
  :group 'loco)

(defun org-cursor-heading-value()
  ;;
  (car (last (org-element-map (org-element-parse-buffer) 'headline'
    (lambda (x)
        (let ((beginval (org-element-property :begin x))
              (current (org-element-property :begin (org-element-at-point))))
        (when (< beginval current)
            (org-element-property :raw-value x))))))))

(defun locojay/org-pandoc-html5 (dir &optional pargs)
  (if (not (file-exists-p dir)) (make-directory dir))
  (let ((command (concat ;;convert-command
                         ;;" "
                         "./convert_note_file.sh "
                         (buffer-name)
                         " > "
                         (file-name-sans-extension (buffer-name))
                         ".html")))
    (message command)
    (shell-command-to-string command)))

;; (defun org-preview-html-at-cursor-heading ()
;;   (let ((cursorheading (org-cursor-heading-value))
;;         (url (url-encode-url (concat "file://" (file-name-sans-extension (buffer-file-name)) ".html")))
;;         (buffername (concat "*xwidget webkit: " (get-orgfile-title (buffer-file-name)) " *")))
;;     (cond ((and cursorheading (get-buffer buffername))
;;            (xwidget-webkit-browse-url (concat url "#" (pandoc-href-from-val cursorheading))))
;;           (cursorheading
;;            (xwidget-webkit-browse-url (concat url "#" (pandoc-href-from-val cursorheading)) t))
;;           ((get-buffer buffername) (xwidget-webkit-browse-url url))
;;           ((not cursorheading) (xwidget-webkit-browse-url url t)))))

;; (defun org-preview-html-at-cursor-heading ()
;;   (let ((cursorheading (org-cursor-heading-value))
;;         (url (url-encode-url (concat "file://" (file-name-sans-extension (buffer-file-name)) ".html")))
;;         (buffername (concat "*xwidget webkit: " (get-orgfile-title (buffer-file-name)) " *")))
;;     (progn
;;         (cond ((and cursorheading (get-buffer buffername))
;;                 (xwidget-webkit-browse-url (concat url "#" (pandoc-href-from-val cursorheading))))
;;                 (cursorheading
;;                 (xwidget-webkit-browse-url (concat url "#" (pandoc-href-from-val cursorheading)) t))
;;                 ((get-buffer buffername) (xwidget-webkit-browse-url url))
;;                 ((not cursorheading) (xwidget-webkit-browse-url url t)))
;;         ;;(pop-to-buffer (get-buffer buffername))
;;         ;;(display-buffer-in-direction (get-buffer buffername) ((direction . below)))
;;         (display-buffer (get-buffer buffername)     '(display-buffer-in-direction
;;                                    (direction . right)))
;;         )))

(defun org-preview-html-at-cursor-heading ()
  (let* ((cursorheading (org-cursor-heading-value))
        (mainurl (url-encode-url (concat "file://" (file-name-sans-extension (buffer-file-name)) ".html")))
        (buffername (concat "*xwidget webkit: " (get-orgfile-title (buffer-file-name)) " *"))
        (url (if cursorheading (concat mainurl "#" (pandoc-href-from-val cursorheading)) mainurl))
        (newsession (if (get-buffer buffername) nil t))
        )
    ;;(progn
      ;;(print url)
      ;;(print newsession)
      (if newsession
          (with-selected-window (split-window-right)
            (xwidget-webkit-browse-url url t))
        (progn
          (display-buffer (get-buffer buffername)))
          (xwidget-webkit-browse-url url)
          )
     ;;(with-selected-window (split-window-right)
     ;;  (xwidget-webkit-browse-url url session))
     ));)

(defun org-webkit-preview/org-preview-html()
  (interactive)
   ;(when (eq major-mode 'org-mode)
      (save-buffer)
      (locojay/org-pandoc-html5 "./")
      (org-preview-html-at-cursor-heading)
      ;)
   )

(defun org-webkit-preview/start-preview()
  (interactive)
  (when (eq major-mode 'org-mode)
    (add-hook 'after-save-hook #'org-webkit-preview/org-preview-html)
    (message "org-webkit-preview is turned on")
    (org-webkit-preview/org-preview-html)))

(defun org-webkit-preview/stop-preview()
  (interactive)
  (remove-hook 'after-save-hook #'org-webkit-preview/org-preview-html)
    (message "org-webkit-preview is turned off"))

(provide 'org-webkit-preview)
