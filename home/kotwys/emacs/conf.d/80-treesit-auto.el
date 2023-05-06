(require 'treesit-auto)
(global-treesit-auto-mode)

(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-ts-mode))
