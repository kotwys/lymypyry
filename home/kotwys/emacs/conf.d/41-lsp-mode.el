(autoload 'lsp-deferred "lsp-mode" nil t)

(setq-default lsp-warn-no-matched-clients nil)
;; Automatically try to start language server for these modes.
(mapc (lambda (hook)
        (add-hook hook #'lsp-deferred))
      '(rust-mode-hook haxe-mode-hook))

(with-eval-after-load 'lsp-haxe
  (custom-set-variables
   `(lsp-clients--haxe-server-path
     ,(expand-file-name "~/haxe-language-server.js"))))
