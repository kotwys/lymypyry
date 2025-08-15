;; -*- lexical-binding: t -*-
(use-package clojure-mode
  :mode
  ("\\.clj\\'" . clojure-mode)
  ("\\.cljs\\'" . clojurescript-mode)
  ("\\.cljc\\'" . clojurec-mode)

  :custom-face
  (clojure-keyword-face ((t (:slant italic :inherit font-lock-constant-face)))))

(use-package cider
  :custom (cider-xref-fn-depth 90))

(use-package markdown-mode :mode "\\.md\\'")
(use-package nix-mode :mode "\\.nix\\'")
(use-package pascal-ts-mode :mode "\\.pas\\'")
(use-package rust-mode :mode "\\.rs\\'")

(use-package ttl-mode
  :mode "\\.ttl\\'"
  :config (add-hook 'ttl-mode-hook 'turn-on-font-lock)
  :custom
  (ttl-electric-punctuation . nil)
  (ttl-indent-on-idle-timer . nil))

(use-package org
  :custom (org-confirm-babel-evaluate nil)
  :config
  (dolist (mode '("python" "ipython"))
    (add-to-list 'org-src-lang-modes (cons mode 'python-ts))))

(setq-default tex-fontify-script nil)
(add-hook 'tex-mode-hook 'electric-pair-local-mode)

(setq-default dired-dwim-target t)

(use-package yaml
  :mode
  (("\\.ya?ml\\'" . yaml-mode)))
