;; -*- lexical-binding: t -*-
(use-package smartparens-config
  :defines smartparens-mode-map
  :bind (:map smartparens-mode-map
         ("C-M-b" . sp-backward-sexp)
         ("C-M-d" . sp-down-sexp)
         ("C-M-a" . sp-backward-down-sexp)
         ("C-M-e" . sp-up-sexp)
         ("C-M-u" . sp-backward-up-sexp)
         ("C-M-t" . sp-transpose-sexp)
         ("C-<right>" . sp-forward-slurp-sexp)
         ("C-<left>" . sp-forward-barf-sexp)
         ("C-," . sp-backward-slurp-sexp)
         ("C-." . sp-backward-barf-sexp)))
