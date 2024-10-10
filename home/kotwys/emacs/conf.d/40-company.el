;; -*- lexical-binding: t -*-
(use-package company
  :hook ((prog-mode nxml-mode cider-repl-mode) . company-mode))
