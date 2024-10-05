;; -*- lexical-binding: t -*-
(use-package treesit-auto
  :config
  (setq treesit-auto-recipe-list
        (seq-filter (lambda (r) (not (eq (treesit-auto-recipe-lang r) 'html)))
                    treesit-auto-recipe-list))
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))
