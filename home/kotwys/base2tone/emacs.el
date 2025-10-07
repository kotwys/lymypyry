;; Base2Tone theme generator for Emacs   -*- lexical-binding: t -*-
(require 'yaml)
(require 'dash)
(require 'color)

(let* ((this-dir  (file-name-directory (buffer-file-name)))
       (load-path (append (list this-dir) load-path)))
  (require 'base2tone-lib))

(defun vector:apply3 (fn vec)
  (funcall fn (aref vec 0) (aref vec 1) (aref vec 2)))

(defun edit-as-hsl (fn color)
  (->> color
       append
       (--map (/ it 255.0))
       (apply #'color-rgb-to-hsl)
       (apply fn)
       (apply #'color-hsl-to-rgb)
       (--map (truncate (* it 255.0)))
       vconcat))

(defun lighten (color d)
  (edit-as-hsl (lambda (h s l)
                 (color-lighten-hsl h s l (* 100 d)))
               color))

(defun darken (color d)
  (lighten color (* -1 d)))

(defun css (color)
  (format "#%02x%02x%02x"
          (aref color 0) (aref color 1) (aref color 2)))

(defun make-emacs-theme (theme-name colors)
  (b2t:with-base-colors colors
   `((deftheme ,theme-name)
     (custom-theme-set-faces ',theme-name
      '(default
        ((((type tty)))
         (t (:background ,(css b2t:A0)
             :foreground ,(css b2t:A7)))))
      '(cursor
        ((t (:background ,(css b2t:D5)))))
      '(success
        ((t (:foreground ,(css b2t:D6)))))
      '(error
        ((t (:foreground ,(css b2t:D2)
             :weight bold))))
      '(link
        ((t (:foreground ,(css b2t:D6)
             :underline t))))
      '(link-visited
        ((t (:inherit link
             :foreground ,(css b2t:D2)))))
      '(button
        ((t (:inherit link
             :underline nil))))
      '(region
        ((t (:background ,(css b2t:A1)))))
      '(secondary-selection
        ((t (:background ,(css b2t:B0)))))
      '(highlight
        ((t (:background ,(css b2t:A1)))))
      '(lazy-highlight
        ((t (:background ,(css b2t:A2)))))
      '(match
        ((t (:foreground ,(css b2t:D4)
             :underline t))))
      '(line-number
        ((t (:inherit default
             :foreground ,(css b2t:A2)))))
      '(line-number-current-line
        ((t (:inherit line-number
             :foreground ,(css b2t:A3)))))
      '(window-divider
        ((t (:background ,(css (darken b2t:A0 0.2))
             :foreground ,(css (darken b2t:A0 0.2))))))
      '(vertical-border ((t (:inherit window-divider))))
      '(tooltip
        ((t (:background ,(css b2t:A0)
             :foreground ,(css b2t:A7)))))
      '(widget-inactive
        ((t (:foreground ,(css b2t:A2)))))
      '(widget-field
        ((t (:background ,(css b2t:A0)
             :foreground ,(css b2t:C7)))))
      '(help-key-binding
        ((t (:background ,(css b2t:A0)
             :foreground ,(css b2t:D0)))))
      '(completions-common-part
        ((t (:foreground ,(css b2t:D7)))))
      '(fixed-pitch-serif ((t nil)))
      '(mode-line
        ((t (:background "grey75"
             :foreground "black"))))
      '(mode-line-inactive
        ((t (:inherit mode-line
             :background "grey30"
             :foreground "grey80"))))
      '(meow-position-highlight-number
        ((t (:background ,(css b2t:A1)
             :foreground ,(css b2t:D2)))))

      '(ansi-color-black
        ((t (:background ,(css b2t:A0)
             :foreground ,(css b2t:A0)))))
      '(ansi-color-red
        ((t (:background ,(css b2t:B2)
             :foreground ,(css b2t:B2)))))
      '(ansi-color-green
        ((t (:background ,(css b2t:D4)
             :foreground ,(css b2t:D4)))))
      '(ansi-color-yellow
        ((t (:background ,(css b2t:D7)
             :foreground ,(css b2t:D7)))))
      '(ansi-color-blue
        ((t (:background ,(css b2t:B3)
             :foreground ,(css b2t:B3)))))
      '(ansi-color-magenta
        ((t (:background ,(css b2t:D4)
             :foreground ,(css b2t:D4)))))
      '(ansi-color-cyan
        ((t (:background ,(css b2t:B4)
             :foreground ,(css b2t:B4)))))
      '(ansi-color-white
        ((t (:background ,(css b2t:A7)
             :foreground ,(css b2t:A7)))))
      '(ansi-color-bright-black
        ((t (:background ,(css b2t:A3)
             :foreground ,(css b2t:A3)))))
      '(ansi-color-bright-red
        ((t (:background ,(css b2t:D5)
             :foreground ,(css b2t:D5)))))
      '(ansi-color-bright-green
        ((t (:background ,(css b2t:D4)
             :foreground ,(css b2t:D4)))))
      '(ansi-color-bright-yellow
        ((t (:background ,(css b2t:D7)
             :foreground ,(css b2t:D7)))))
      '(ansi-color-bright-blue
        ((t (:background ,(css b2t:B3)
             :foreground ,(css b2t:B3)))))
      '(ansi-color-bright-magenta
        ((t (:background ,(css b2t:D4)
             :foreground ,(css b2t:D4)))))
      '(ansi-color-bright-cyan
        ((t (:background ,(css b2t:D3)
             :foreground ,(css b2t:D3)))))
      '(ansi-color-bright-white
        ((t (:background ,(css b2t:B7)
             :foreground ,(css b2t:B7)))))

      '(tab-bar
        ((t (:background ,(css b2t:A1)))))
      '(tab-bar-tab
        ((t (:background ,(css b2t:A2)))))
      '(tab-bar-tab-group-current
        ((t (:background ,(css b2t:A2)
             :weight bold))))
      '(tab-bar-tab-group-inactiv
        ((t (:background ,(css b2t:A2)))))
      '(tab-bar-tab-inactive
        ((t (:background ,(css b2t:A1)))))
      '(tab-bar-tab-ungrouped
        ((t (:background ,(css b2t:A1)))))
      '(tab-line
        ((t (:background ,(css b2t:A1)))))

      '(tty-menu-disabled-face
        ((t (:background ,(css b2t:A0)
             :foreground ,(css b2t:C5)))))
      '(tty-menu-enabled-face
        ((t (:inherit tty-menu-disabled-face
             :foreground ,(css b2t:D7)))))
      '(tty-menu-selected-face
        ((t (:background ,(css b2t:A1)))))

      '(font-lock-builtin-face
        ((t (:foreground ,(css b2t:B2)))))
      '(font-lock-comment-face
        ((t (:foreground ,(css b2t:A3)
             :slant italic))))
      '(font-lock-doc-face ((t (:inherit font-lock-comment-face))))
      '(font-lock-constant-face
        ((t (:foreground ,(css b2t:D7)))))
      '(font-lock-number-face
        ((t (:foreground ,(css b2t:D7)))))
      '(font-lock-operator-face
        ((t (:foreground ,(css b2t:D2)))))
      '(font-lock-function-name-face
        ((t (:foreground ,(css b2t:B7)))))
      '(font-lock-variable-name-face
        ((t (:foreground ,(css b2t:B7)))))
      '(font-lock-keyword-face
        ((t (:foreground ,(css b2t:D2)))))
      '(font-lock-string-face
        ((t (:foreground ,(css b2t:D5)))))
      '(font-lock-type-face
        ((t (:foreground ,(css b2t:D7)
             :slant italic))))
      '(font-lock-variable-face
        ((t (:foreground ,(css b2t:B5)))))
      '(sh-heredoc
        ((t (:foreground ,(css b2t:D5)))))

      '(header-line
        ((t (:background ,(css b2t:A1)
             :foreground ,(css b2t:D5)
             :weight bold))))
      '(magit-branch-current
        ((t (:background ,(css b2t:B3)
             :foreground ,(css b2t:A0)))))
      '(magit-branch-local
        ((t (:foreground ,(css b2t:B3)))))
      '(magit-branch-remote
        ((t (:foreground ,(css b2t:D0)))))
      '(magit-branch-remote-head
        ((t (:background ,(css b2t:D0)
             :foreground ,(css b2t:A0)))))
      '(magit-branch-warning
        ((t (:foreground ,(css b2t:D3)
             :slant italic))))
      '(magit-head
        ((t (:foreground ,(css b2t:B3)))))
      '(magit-header-line
        ((t (:foreground ,(css b2t:D5)
             :weight bold))))
      '(magit-section-heading
        ((t (:foreground ,(css b2t:D5)
             :weight bold))))
      '(magit-section-heading-select
        ((t (:inherit magit-section-heading
             :background ,(css b2t:A1)))))

      '(eglot-highlight-symbol-face
        ((t (:background ,(css b2t:A1)))))
      '(company-tooltip
        ((t (:background ,(css b2t:A0)
             :foreground ,(css b2t:C5)))))
      '(company-tooltip-annotation
        ((t (:foreground ,(css b2t:A2)))))
      '(company-tooltip-common
        ((t (:foreground ,(css b2t:D7)))))
      '(company-tooltip-selection
        ((t (:background ,(css b2t:A1)))))
      '(company-tooltip-scrollbar-thumb
        ((t (:background ,(css b2t:D0)))))
      '(company-tooltip-scrollbar-track
        ((t (:background ,(css b2t:A0)))))
      '(lsp-flycheck-warning-unnecessary-face
        ((t (:underline t))))
      '(lsp-lens-face
        ((t (:foreground ,(css b2t:A3)))))

      '(nix-constant-face
        ((t (:foreground ,(css b2t:D5)))))
      '(markdown-header-face
        ((t (:foreground ,(css b2t:D5)
             :weight bold))))

      '(org-document-titl
        ((t (:foreground ,(css b2t:D5)
             :weight bold))))
      '(org-footnote
        ((t (:foreground ,(css b2t:D7)
             :slant italic))))

      '(minibuffer-prompt
        ((t (:foreground ,(css b2t:D0)))))
      '(show-paren-match
        ((t (:background ,(css b2t:A0)
             :foreground ,(css b2t:D4)
             :underline t))))
      '(show-paren-mismatch
        ((t (:background ,(css b2t:D2)
             :foreground ,(css b2t:A0))))))
     (provide-theme ',theme-name))))

(defun generate-theme (config-path)
  (with-temp-buffer
    (insert-file-contents config-path)
    (let* ((c          (yaml-parse-string (buffer-string)))
           (theme-name (make-symbol (downcase (gethash 'scheme c)))))
      (mapc #'prin1 (make-emacs-theme theme-name c)))))
