(autoload 'lsp-deferred "lsp-mode" nil t)

(setq-default lsp-warn-no-matched-clients nil)
;; Automatically try to start language server for these modes.
(mapc (lambda (hook)
        (add-hook hook #'lsp-deferred))
      '(rust-mode-hook kotlin-mode-hook))

(with-eval-after-load 'lsp-kotlin
  (custom-set-variables
   `(lsp-clients-kotlin-server-executable
     ,(expand-file-name "~/.local/share/kotlin-language-server/bin/kotlin-language-server"))))
