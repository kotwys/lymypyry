(autoload 'global-flycheck-mode "flycheck" nil t)
(add-hook 'after-init-hook #'global-flycheck-mode)

(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
