(set-frame-font "Cascadia Code-10" nil t)
(set-face-attribute 'default nil :height 120)

(menu-bar-mode -1)
(xterm-mouse-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)

(keymap-global-set "<mouse-5>" 'custom-scroll-up)
(keymap-global-set "<mouse-4>" 'custom-scroll-down)
(keymap-global-unset "C-<down-mouse-1>")
(keymap-global-unset "C-<down-mouse-2>")
(keymap-global-unset "C-<down-mouse-3>")
(defun custom-scroll-down ()
  (interactive)
  (scroll-down 1))
(defun custom-scroll-up ()
  (interactive)
  (scroll-up 1))

(transient-mark-mode t)

(set-language-environment "UTF-8")

(show-paren-mode 1)
(setq show-paren-when-point-inside-paren t)
(setq make-backup-files nil)
(setq auto-save-default nil)

(column-number-mode 1)
(line-number-mode 1)

(setq-default scroll-conservatively 100)

(setq-default indent-tabs-mode nil)

(setq-default fill-column 80)
(setq-default truncate-lines t)
(add-hook 'text-mode-hook
          (lambda ()
            (setq truncate-lines nil)))
(add-hook 'text-mode-hook 'auto-fill-mode)

(setq-default display-line-numbers-width 3)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'electric-pair-local-mode)

(add-to-list 'load-path
             (concat user-emacs-directory "site-lisp/"))
(add-to-list 'custom-theme-load-path
             (concat user-emacs-directory "themes/"))

(load-theme 'base2tone-motel t)

(mapc (lambda (path)
        (load-file path))
      (directory-files (concat user-emacs-directory "/conf.d/")
                       t "\.el$"))
