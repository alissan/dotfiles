;;emacs configuration #
;;(toggle-frame-fullscreen)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;;(set-default-font "Fira Code Retina 10" )

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-language-environment 'utf-8)
(set-selection-coding-system 'utf-8)

(desktop-save-mode 1)

(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("elpy" . "https://jorgenschaefer.github.io/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (org-super-agenda ht log4j-mode logview vlf htmlize evil org ox-twbs magit evil-leader git helm elpy evil-visual-mark-mode evil-escape)))
 '(safe-local-variable-values
   (quote
    ((eval when
	   (locate-library "rainbow-mode")
	   (require
	    (quote rainbow-mode))
	   (rainbow-mode)))))
 '(send-mail-function (quote mailclient-send-it)))
 
; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-selected-packages)
  (unless (package-installed-p package)
    (package-install package)))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:foreground "#084B8A"))))
 '(org-level-2 ((t (:foreground "#7B241C"))))
 '(org-level-3 ((t (:foreground "#4F2A4A")))))

(require 'evil)
(evil-mode t)
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "b" 'switch-to-buffer
  "w" 'save-buffer
  "d" 'kill-this-buffer
  "1" 'helm-filtered-bookmarks
  "o" 'occur
  "ee" 'eval-buffer
  "f" 'helm-find-files
  "x" 'helm-M-x
  "s" 'evil-ex-search-forward
  "," 'other-window
  "i" 'describe-bindings
  "g" 'keyboard-quit
  "r" 'redo
  "ex" 'org-export-dispatch
  "c" 'org-capture
  "a" 'org-agenda-month-view
  "tg" 'org-set-tags-command
  "h" 'org-schedule
  "a" 'org-agenda
  "p" 'run-python
  "m" 'mail
  )
(setq evil-motion-state-modes (append evil-emacs-state-modes evil-motion-state-modes))
(setq evil-emacs-state-modes nil)

(setq inhibit-startup-screen t)
(elpy-enable)

(defalias 'ts 'org-time-stamp-inactive)

(require 'helm-config)

(helm-mode 1)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)

(define-key helm-find-files-map "\t" 'helm-execute-persistent-action)

(require 'git)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

 (setq org-confirm-babel-evaluate nil)
  (setq org-export-babel-evaluate nil)

  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)

(global-hl-line-mode 1)
(toggle-truncate-lines 1)
(evil-select-search-module 'evil-search-module 'evil-search)


;;(evil-add-hjkl-bindings occur-mode-map 'emacs
;;  (kbd "/")       'evil-search-forward
;;  (kbd "n")       'evil-search-next
;;  (kbd "N")       'evil-search-previous
;;  (kbd "C-d")     'evil-scroll-down
;;  (kbd "C-u")     'evil-scroll-up
;; (Kbd, "C-w C-w") 'other-window)
(evil-escape-mode 1)
(setq-default evil-escape-key-sequence "..")
(setq-default evil-escape-delay 0.2)



(setq bookmark-save-flag 1)



(setq shell-file-name "bash")
(setenv "SHELL" shell-file-name)
(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)

(set-face-background 'mode-line "#b3b3ff")
;;(set-face-background 'mode-line "#EBDEF0")
;;(set-face-background 'mode-line "#F4ECF7") 

;;(display-time-mode 1)
;;(setq display-time-day-and-date t
;;                display-time-24hr-format t)
;;             (display-time)
(setq display-time-string-forms
      '((propertize (format-time-string "[%Y.%m.%d %H:%M]" now) 'face 'bold)))

(display-time-mode 1)

(add-to-list 'org-structure-template-alist '("C" "#+begin_comment\n?\n#+end_comment"))

(defun now()
  (interactive)
  (insert (format-time-string "[%02Y.%02m.%02d %02H:%02M.%02S]")))

(setq column-number-mode t)
(set-face-attribute 'default nil :height 110)

(setq org-todo-keywords
  '(
;;(sequence "TODO" "IN-PROGRESS" "|" "DONE" "POSTPONED" "CANCELED")
;;(sequence "TODO" "IN-PROGRESS" "|" "DONE")
(sequence "TODO" "|" "DONE")
))

(setq org-todo-keyword-faces
       '(
	 ("TODO" . (:foreground "#FE642E" :weight bold))
	 ;;("CANCELED" . (:foreground "red" :weight bold))
	 ("DONE" . (:foreground "#008000" :weight bold))
	 ;;("POSTPONED" . (:foreground "#4000ff" :weight bold))
	 ;;("IN-PROGRESS" . (:foreground "#084B8A" :weight bold))
	)
 )

 (setq org-capture-templates
      '(("t" "todo" entry (file "/path/to/orgfile.org")
             "* TODO %? - %U.")
        ;;("j" "journal" entry (file+olp+datetree "/path/to/journal.org")
        ;; "* %U - %?\n  %i\n  %a")
))


(setq org-agenda-files (quote ("/path/to/orgfile.org" )))

(setq org-log-done 'time)
;;(setq org-log-done 'note)


(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"))

;;(setq python-shell-interpreter "python")
;;(setq python-shell-interpreter-args "--pylab -i")

(with-eval-after-load 'python
  (defun python-shell-completion-native-try ()
    "Return non-nil if can trigger native completion."
    (let ((python-shell-completion-native-enable t)
          (python-shell-completion-native-output-timeout
           python-shell-completion-native-try-output-timeout))
      (python-shell-completion-native-get-completions
       (get-buffer-process (current-buffer))
       nil "_"))))


(custom-theme-set-faces 'user
                        `(org-level-1 ((t (:foreground "#084B8A")))))
(custom-theme-set-faces 'user
                        ;;`(org-level-2 ((t (:foreground "#7B241C")))))
                        `(org-level-2 ((t (:foreground "#9B59B6")))))
(custom-theme-set-faces 'user
                        `(org-level-3 ((t (:foreground "#4F2A4A")))))



;;for macos
(if (boundp 'ns-command-modifier)
    (setq ns-command-modifier 'meta))

(if (boundp 'ns-option-modifier)
    (setq ns-option-modifier nil))

(getenv "PATH")
 (setenv "PATH"
(concat
 "/Library/TeX/texbin/" ":"

(getenv "PATH")))

(setq epa-pinentry-mode 'loopback)

(require 'epa-file)
(custom-set-variables '(epg-gpg-program  "/usr/local/bin/gpg"))
(epa-file-enable)
