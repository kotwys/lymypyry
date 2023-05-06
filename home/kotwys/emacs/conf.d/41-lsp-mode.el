(autoload 'lsp-deferred "lsp-mode" nil t)

(setq lsp-modes '(rust-mode-hook rust-ts-mode-hook))
(mapc (lambda (hook)
        (add-hook hook #'lsp-deferred))
      lsp-modes)
