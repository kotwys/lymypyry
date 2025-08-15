;; -*- lexical-binding: t -*-
(use-package lsp-mode
  :disabled
  :autoload lsp-deferred
  :hook ((clojure-mode csharp-mode rust-mode) . lsp-deferred))
