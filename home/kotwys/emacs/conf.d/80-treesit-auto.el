(require 'treesit-auto)
(global-treesit-auto-mode)

(setq treesit-auto-recipe-list
      (seq-filter (lambda (r)
                    (not (eq (treesit-auto-recipe-lang r) 'html)))
                  treesit-auto-recipe-list))
(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-ts-mode))
