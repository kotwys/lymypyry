(with-eval-after-load 'org
  (setq org-confirm-babel-evaluate nil)
  (add-to-list 'org-src-lang-modes '("python" . python-ts))
  (add-to-list 'org-src-lang-modes '("ipython" . python-ts)))
