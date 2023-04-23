(mapc (lambda (p)
        (progn
          (autoload (cdr p) "clojure-mode" nil t)
          (add-to-list 'auto-mode-alist p)))
      '(("\\.clj\\'" . clojure-mode)
        ("\\.cljs\\'" . clojurescript-mode)
        ("\\.cljc\\'" . clojurec-mode)))
