(autoload 'lsp-deferred "lsp-mode" nil t)

(setq-default lsp-warn-no-matched-clients nil)
;; Automatically try to start language server for these modes.
(mapc (lambda (hook)
        (add-hook hook #'lsp-deferred))
      '(rust-mode-hook rust-ts-mode-hook))
