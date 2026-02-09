;;; ~/.doom.d/init.el -*- lexical-binding: t; -*-

(doom! :completion
       (corfu +dabbrev +icons)
       (vertico +icons)

       :ui
       (doom +tabs)
       modeline
       doom-dashboard
       doom-quit
       hl-todo
       indent-guides
       ophints
       (popup +defaults)
       (vc-gutter +diff-hl +pretty)
       (workspaces +tabs)
       (emoji +unicode)
       treemacs
       tree-sitter
       (window-select +switch-window)   

       :editor
       (evil +everywhere)
       file-templates
       fold              
       (format +onsave)  
       multiple-cursors  ; editing in many places at once
       rotate-text       ; cycle region at point between text candidates
       snippets
       (whitespace +guess +trim)
       word-wrap

       :emacs
       (dired +dirvish +icons)
       ;; electric          ; smarter, keyword-based electric-indent
       (ibuffer +icons)  
       (undo +tree)      
       vc

       :term
       vterm

       :checkers
       syntax
       (syntax +childframe)
       ;;grammar

       :tools
       (lsp +eglot)
       tree-sitter
       direnv
       editorconfig        
       (eval +overlay)
       (lookup +docsets +dictionary)
       (magit +childframe +forge)
       (pass +auth)        
       terraform           

       :os
       (:if IS-MAC macos)
       tty                 ; enable terminal integration

       :lang
       emacs-lisp
       (javascript +lsp +tree-sitter)
       (json +tree-sitter)
       (go +lsp +tree-sitter)
       (markdown +tree-sitter)
       ;;(nix +lsp +tree-sitter)
       (org +dragndrop +roam2 +pretty +forge +jupyter)
       (python +lsp +tree-sitter +pyright)
       (sh +fish +lsp)
       (web +lsp +tree-sitter)
       (yaml +lsp +tree-sitter)
       (json +lsp +tree-sitter)

       :config
       ;;literate
       (default +bindings +smartparens))
