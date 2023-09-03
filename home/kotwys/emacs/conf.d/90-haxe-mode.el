(define-derived-mode haxe-mode javascript-mode "Haxe"
  "Major mode for Haxe based on JavaScript mode."
  (setq js-indent-level 2)
  (setq js-switch-indent-offset 2)
  (setq js-paren-indent-offset 0)
  (setq js-chain-indent nil)
  (setq js-indent-align-list-continuation nil))

(add-to-list 'auto-mode-alist '("\\.hx\\'" . haxe-mode))
