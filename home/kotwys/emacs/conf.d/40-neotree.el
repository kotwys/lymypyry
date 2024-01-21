(with-eval-after-load 'neotree
  (setq-default neo-mode-line-type 'none))

(autoload 'neotree-toggle "neotree" nil t)
(global-set-key (kbd "C-c t") 'neotree-toggle)
