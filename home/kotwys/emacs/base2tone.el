(require 'yaml)

(defun hex-color (x)
  (concat "#"
          (cond ((stringp x) x)
                ((numberp x) (number-to-string x)))))

(defmacro with-base-colors (table &rest body)
  `(let ,(mapcar #'(lambda (key)
                     `(,key (hex-color
                             (gethash (intern-soft
                                       ,(concat "base"
                                                (upcase (symbol-name key))))
                                      ,table))))
                 '(a0 a1 a2 a3 a4 a5 a6 a7
                   b0 b1 b2 b3 b4 b5 b6 b7
                   c0 c1 c2 c3 c4 c5 c6 c7
                   d0 d1 d2 d3 d4 d5 d6 d7))
     ,@body))

(defun generate-theme (config-path)
  (with-temp-buffer
    (insert-file-contents config-path)
    (let* ((c (yaml-parse-string (buffer-string)))
           (theme-name (make-symbol (downcase (gethash 'scheme c)))))
      (with-base-colors c
        (pp `(deftheme ,theme-name))
        (terpri)
        (pp `(custom-theme-set-faces (quote ,theme-name)
              '(default ((((type tty))) 
                         (t (:background ,a0 :foreground ,c7))))
              '(cursor ((t (:background ,d5))))
	      '(success ((t (:foreground ,d6))))
              '(error ((t (:foreground ,d2 :weight bold))))
              '(link ((t (:foreground ,d6 :underline t))))
	      '(link-visited ((t (:inherit link :foreground ,d2))))
              '(button ((t (:inherit link :underline nil))))
              '(region ((t (:background ,a1))))
              '(secondary-selection ((t (:background ,b0))))
	      '(highlight ((t (:background ,b0))))
              '(match ((t (:foreground ,d4 :underline t))))
	      '(line-number ((t (:foreground ,a2))))
	      '(line-number-current-line ((t (:foreground ,a3))))
              '(window-divider ((t (:background ,a0 :foreground ,a3))))
              '(vertical-border ((t (:inherit window-divider))))
              '(tooltip ((t (:background ,d0 :foreground ,a0))))

              '(tab-bar ((t (:background ,a1))))
              '(tab-bar-tab ((t (:background ,a2))))
              '(tab-bar-tab-group-current ((t (:background ,a2 :weight bold))))
              '(tab-bar-tab-group-inactive ((t (:background ,a2))))
              '(tab-bar-tab-inactive ((t (:background ,a1))))
              '(tab-bar-tab-ungrouped ((t (:background ,a1))))
              '(tab-line ((t (:background ,a1))))
        
              '(font-lock-builtin-face ((t (:foreground ,b2))))
              '(font-lock-comment-face ((t (:foreground ,a3 :slant italic))))
              '(font-lock-doc-face ((t (:inherit font-lock-comment-face))))
              '(font-lock-constant-face ((t (:foreground ,d7))))
              '(font-lock-number-face ((t (:foreground ,d7))))
              '(font-lock-operator-face ((t (:foreground ,d2))))
              '(font-lock-function-name-face ((t (:foreground ,b7))))
              '(font-lock-variable-name-face ((t (:foreground ,b7))))
              '(font-lock-keyword-face ((t (:foreground ,d2))))
              '(font-lock-string-face ((t (:foreground ,d5))))
              '(font-lock-type-face ((t (:foreground ,d7 :slant italic))))
              '(font-lock-variable-face ((t (:foreground ,b5))))
              '(sh-heredoc ((t (:foreground ,d5))))

              '(header-line ((t (:background ,a1 :foreground ,d5 :weight bold))))
              '(magit-branch-current ((t (:background ,b3 :foreground ,a0))))
              '(magit-branch-local ((t (:foreground ,b3))))
              '(magit-branch-remote ((t (:foreground ,d0))))
              '(magit-branch-remote-head ((t (:background ,d0 :foreground ,a0))))
              '(magit-branch-warning ((t (:foreground ,d3 :slant italic))))
              '(magit-head ((t (:foreground ,b3))))
              '(magit-header-line ((t (:foreground ,d5 :weight bold))))
              '(magit-section-heading ((t (:foreground ,d5 :weight bold))))
              '(magit-section-heading-select ((t (:inherit magit-section-heading :background ,a1))))

              '(nix-constant-face ((t (:foreground ,d5))))

	      '(minibuffer-prompt ((t (:foreground ,d0))))
	      '(show-paren-match ((t (:background ,a0 :foreground ,d4 :underline t))))
              '(show-paren-mismatch ((t (:background ,d2 :foreground ,a0))))))
        (terpri)
        (pp `(provide-theme (quote ,theme-name)))))))