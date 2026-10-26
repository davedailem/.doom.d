;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;____________________________________________________________
;;

;; Minimal UI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Prevents some cases of Emacs flickering.
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

;; Start fullscreen
;; (add-hook 'window-setup-hook #'toggle-frame-fullscreen)

;; Manual auto complete
;; (after! corfu
;;   (setq corfu-auto nil))

(setq
 ;; theme and fonts (doom-one, doom-dracula)
 doom-theme 'doom-dracula
 doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14 :weight 'light)
 doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 14)

 ;; For relative line numbers, set this to `relative'.
 display-line-numbers-type t

 ;; Password cache and auth
 password-cache t
 password-cache-expiry nil
 auth-sources '((:source "~/.authinfo.gpg"))

 ;; Remove duplicates in commands history
 history-delete-duplicates t

 ;; tell projectile not to register projects automatically
 projectile-track-known-projects-automatically nil

 ;; don't yank on paste
 evil-kill-on-visual-paste nil

 ;; Focus new window after splitting
 evil-split-window-below t
 evil-vsplit-window-right t

 ;; add clipboard to the kill-ring before next kill
 save-interprogram-paste-before-kill t

 ;; No comments on new lines when pressing RET
 +default-want-RET-continue-comments nil

 ;; the default is too high and makes vterm to slow
 vterm-timer-delay 0.01

 ;; An evil mode indicator is redundant with cursor shape
 doom-modeline-modal nil

 ;; ibuffer: no prompts
 ibuffer-expert t

 ;; clangd
 lsp-clients-clangd-args
 '("-j=3"
   "--background-index"
   "--clang-tidy"
   "--completion-style=detailed"
   "--header-insertion=never"
   "--header-insertion-decorators=0"))

(setq-default indent-tabs-mode nil)

;; enable evil escape
(after! evil-escape
  (setq evil-escape-key-sequence "jk"))

;;____________________________________________________________
;; modeline configs
(use-package! doom-modeline
  :hook (doom-modeline-mode . display-time-mode)
  :custom
  (line-number-mode nil)
  (doom-modeline-persp-name t)
  (doom-modeline-buffer-encoding nil)
  :config
  (remove-hook 'doom-modeline-mode-hook #'size-indication-mode) ; filesize in modeline
  (remove-hook 'doom-modeline-mode-hook #'column-number-mode))   ; cursor column in modeline

;;____________________________________________________________
;; ibuffer configs
(defun my/ibuffer-setup ()
  (when (fboundp 'ibuffer-projectile-set-filter-groups)
    (ibuffer-projectile-set-filter-groups))
  (unless (eq ibuffer-sorting-mode 'alphabetic)
    (ibuffer-do-sort-by-alphabetic)))
(add-hook 'ibuffer-hook #'my/ibuffer-setup)

;; add spacing between windows
(modify-all-frames-parameters
 '((right-divider-width . 5)
   (bottom-divider-width . 5)))

;;____________________________________________________________
;; org configs
(use-package! org
  :custom
  (org-directory "~/org/")
  (org-archive-location (file-name-concat org-directory ".archive/%s::"))
  (org-agenda-files (list (file-name-concat org-directory "org-agenda")))
  (org-startup-folded t)
  (org-agenda-timegrid-use-ampm 1) ;; Use 12-hour clock instead of 24-hour in agenda view
  (org-capture-templates
   '(("t" "todo" entry (file+headline "todo.org" "Inbox")
      "* [ ] %?\n%i\n%a"
      :prepend t)
     ("d" "deadline" entry (file+headline "todo.org" "Inbox")
      "* [ ] %?\nDEADLINE: <%(org-read-date)>\n\n%i\n%a"
      :prepend t)
     ("s" "schedule" entry (file+headline "todo.org" "Inbox")
      "* [ ] %?\nSCHEDULED: <%(org-read-date)>\n\n%i\n%a"
      :prepend t)
     ("c" "check out later" entry (file+headline "todo.org" "Check out later")
      "* [ ] %?\n%i\n%a"
      :prepend t))))

;; enable auto fill for org
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'markdown-mode-hook 'turn-on-auto-fill)

;;____________________________________________________________
;; org-roam configs
(use-package! org-roam
  :custom
  (org-roam-directory (file-name-concat org-directory "org-roam/"))
  (org-roam-db-location (file-name-concat org-directory ".org-roam.db"))
  (org-roam-dailies-directory (file-name-concat org-directory "journal/"))
  (org-roam-node-display-template
   (concat "${title:*} "
           (propertize "${tags:10}" 'face 'org-tag)))
  :config
  (org-roam-db-autosync-mode)
  (org-roam-db-sync))

;;____________________________________________________________
;; org-modern
(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :custom
  ;; Edit settings
  (org-modern-star 'replace) ;; round bullet points
  (org-auto-align-tags nil)
  (org-tags-column 0)
  (org-fold-catch-invisible-edits 'show-and-error)
  (org-special-ctrl-a/e t)
  (org-insert-heading-respect-content t)

  ;; Org styling, hide markup etc.
  (org-hide-emphasis-markers t)
  (org-pretty-entities t)
  (org-ellipsis "…")

  ;; Agenda styling
  (org-agenda-tags-column 0)
  (org-agenda-block-separator ?─)
  (org-agenda-time-grid
   '((daily today require-timed)
     (800 1000 1200 1400 1600 1800 2000)
     " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")))

;;____________________________________________________________
;; accept completion from copilot
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :config
  (setq copilot-indent-offset-warning-disable t)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))


;;_________________________________________________________
;; some helper functions

;; insert a new line right after the cursor's position
(defun my/open-line ()
  (interactive)
  (save-excursion
    (move-end-of-line 1)
    (open-line 1)))

;; C-Backspace kill one word, a space character or a new line character
(defun my/kill-backward-smart ()
  (interactive)
  (cond
   ((looking-back (rx (char word)) 1)
    (backward-kill-word 1))
   ((looking-back (rx (char blank)) 1)
    (delete-horizontal-space t))
   (t
    (backward-delete-char 1))))

(after! lsp-clangd (set-lsp-priority! 'clangd 2))

;;____________________________________________________________
;; set-mark symbol at point
(defun my/mark-symbol-at-point ()
  (interactive)
  (unless (region-active-p)
    (when-let ((bounds (bounds-of-thing-at-point 'symbol)))
      (goto-char (car bounds))
      (push-mark (car bounds) t t)
      (goto-char (cdr bounds)))))

(after! (:and treemacs ace-window)
  (setq aw-ignored-buffers (delq 'treemacs-mode aw-ignored-buffers)))

;;____________________________________________________________
;; load key bindings
(load-file "~/.doom.d/keybinding.el")

(use-package! lsp-mode
  :commands (lsp lsp-deferred)
  :hook ((cue-mode . lsp-deferred))
  :config
  (put 'lsp-go-build-flags 'safe-local-variable #'vectorp) ; trust lsp-go-build-flags
  (setq lsp-headerline-breadcrumb-enable t)
  (add-to-list 'lsp-language-id-configuration '(cue-mode . "cue"))
  (lsp-register-client (make-lsp-client
                        :new-connection (lsp-stdio-connection (list "cue" "lsp" "serve"))
                        :activation-fn (lsp-activate-on "cue")
                        :server-id 'cuelsp)))

;; enable magit-todos mode
(use-package! magit-todos
  :after magit
  :config (magit-todos-mode 1))

(use-package! agent-shell
  :custom
  (agent-shell-file-completion-enabled t)
  (agent-shell-show-welcome-message nil)
  ;; (agent-shell-prefer-viewport-interaction t)
  (agent-shell-display-action
   '((display-buffer-reuse-window display-buffer-pop-up-frame)
     ;; (inhibit-switch-frame . t)
     (reusable-frames . visible)))
  :config
  (setq agent-shell-preferred-agent-config (agent-shell-github-make-copilot-config)))
