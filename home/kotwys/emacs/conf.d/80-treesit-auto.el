;; -*- lexical-binding: t -*-
(use-package treesit-auto
  :defines
  treesit-auto-langs

  :functions
  treesit-auto-add-to-auto-mode-alist
  global-treesit-auto-mode

  :config
  (dolist (lang '(html c-sharp))
    (delete lang treesit-auto-langs))
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))
