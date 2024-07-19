;;; keybinding.el -*- lexical-binding: t; -*-

;;;____________________________________________________________
;; access the map! documentation with (SPC h f map!)
;; https://discourse.doomemacs.org/t/how-to-re-bind-keys/56

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Note: Need to add the (interactive) to the lambda functions when using them in map!. ;;
;; Kebindings are considered interactive.                                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map! :map 'override
      :desc "kill backward smart"
      :nvig "C-<backspace>" #'my/kill-backward-smart)

(map! :leader
      :desc "other window"              :nv     "RET"   #'other-window
      :desc "open line"                 :nv     "i n"   #'my/open-line
      :desc "yank from kill-ring"       :nvig   "i k"   #'(lambda () (interactive) (yank-pop))
      :desc "mark word at point"        :nvg    "m"     #'er/mark-word
      :desc "increase-height 10"        :nv     "w +"   #'(lambda () (interactive) (evil-window-increase-height 10))
      :desc "decrease-height 10"        :nv     "w -"   #'(lambda () (interactive) (evil-window-decrease-height 10))
      :desc "format whole buffer"       :nv     "c f"   #'lsp-format-region
      :desc "Find usage"                :nv     "c u"   #'lsp-ui-peek-find-references
      :desc "Glance"                    :nv     "c g"   #'lsp-ui-doc-glance
      :desc "Jump backward"             :nv     "c h"   #'lsp-ui-peek-jump-backward
      :desc "Jump forward"              :nv     "c l"   #'lsp-ui-peek-jump-forward
      :desc "Format region"             :nv     "c f"   #'lsp-format-region
      :desc "Show docs"                 :nv     "c s"   #'lsp-ui-doc-show
      )

(map! :map dap-mode-map
      :leader
      :prefix ("d" . "dap")
      ;; basics
      :desc "dap next"          "n" #'dap-next
      :desc "dap step in"       "i" #'dap-step-in
      :desc "dap step out"      "o" #'dap-step-out
      :desc "dap continue"      "c" #'dap-continue
      :desc "dap hydra"         "h" #'dap-hydra
      :desc "dap debug restart" "r" #'dap-debug-restart
      :desc "dap debug"         "s" #'dap-debug

      ;; debug
      :prefix ("dd" . "Debug")
      :desc "dap debug recent"  "r" #'dap-debug-recent
      :desc "dap debug last"    "l" #'dap-debug-last

      ;; eval
      :prefix ("de" . "Eval")
      :desc "eval"                "e" #'dap-eval
      :desc "eval region"         "r" #'dap-eval-region
      :desc "eval thing at point" "s" #'dap-eval-thing-at-point
      :desc "add expression"      "a" #'dap-ui-expressions-add
      :desc "remove expression"   "d" #'dap-ui-expressions-remove

      :prefix ("db" . "Breakpoint")
      :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
      :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
      :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
      :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message)

