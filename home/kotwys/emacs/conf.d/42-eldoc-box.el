;; -*- lexical-binding: t -*-
(use-package eldoc-box
  :hook (eldoc-mode-hook . eldoc-box-hover-at-point-mode)
  :diminish eldoc-box-hover-at-point-mode
  :custom-face
  (eldoc-box-body ((t (:family "Ubuntu")))))
