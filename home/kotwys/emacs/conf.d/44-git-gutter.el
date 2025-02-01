;; -*- lexical-binding: t -*-
(use-package git-gutter
  :hook (after-init . global-git-gutter-mode)
  :custom
  (git-gutter:modified-sign "▏")
  (git-gutter:added-sign    "▏")
  (git-gutter:deleted-sign  "▁")
  :custom-face
  (git-gutter:added    ((t (:foreground "#5e974e"))))
  (git-gutter:modified ((t (:foreground "#6e558a"))))
  (git-gutter:deleted  ((t (:foreground "#8d2b30")))))
