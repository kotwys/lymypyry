(autoload 'yas-global-mode "yasnippet" nil t)
(setq yas-snippet-dirs
      (list (concat user-emacs-directory "/snippets")))
(add-hook 'after-init-hook
          (lambda ()
            (yas-global-mode 1)))
