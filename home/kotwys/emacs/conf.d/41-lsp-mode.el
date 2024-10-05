;; -*- lexical-binding: t -*-
(use-package lsp-mode
  :autoload lsp-deferred
  :hook ((rust-mode) . lsp-deferred))
