;; -*- lexical-binding: nil -*-

(autoload 'ttl-mode "ttl-mode" nil t)
(add-hook 'ttl-mode-hook 'turn-on-font-lock)
(add-to-list 'auto-mode-alist '("\\.ttl\\'" . ttl-mode))

(with-eval-after-load 'ttl-mode
  (custom-set-variables
   '(ttl-electric-punctuation . nil)
   '(ttl-indent-on-idle-timer . nil)))
