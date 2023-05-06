(set-frame-font "Cascadia Code-10" nil t)
(set-face-attribute 'default nil :height 120)

(tool-bar-mode -1)
(menu-bar-mode -1)

(fset 'yes-or-no-p 'y-or-n-p)

(transient-mark-mode t)

(show-paren-mode 1)
(setq show-paren-when-point-inside-paren t)
(setq make-backup-files nil)

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

(add-to-list 'custom-theme-load-path
             (concat user-emacs-directory "/themes/"))

(load-theme 'base2tone-motel t)

(mapc (lambda (path)
        (load-file path))
      (directory-files (concat user-emacs-directory "/conf.d/")
                       t "\.el$"))
