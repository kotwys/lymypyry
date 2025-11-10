;; -*- lexical-binding: t -*-

(use-package highlight-indent-guides
  :hook prog-mode
  :diminish highlight-indent-guides-mode
  :custom
  (highlight-indent-guides-method 'character)
  (highlight-indent-guides-auto-enabled nil)
  (highlight-indent-guides-character ?╎))
