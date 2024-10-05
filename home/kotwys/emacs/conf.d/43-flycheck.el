;; -*- lexical-binding: t -*-
(use-package flycheck
  :hook (prog-mode . flycheck-mode)
  :custom (flycheck-disabled-checkers '(emacs-lisp-checkdoc)))
