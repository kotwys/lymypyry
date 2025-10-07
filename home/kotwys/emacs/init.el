;; -*- lexical-binding: t -*-
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(setq default-frame-alist `((width            . 96)
                            (height           . 24)
                            (alpha-background . 0.85)
                            ,@default-frame-alist))

(set-face-attribute 'default nil
                    :font "PlemolJP35 Console"
                    :height 105)

(setq inhibit-splash-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(fringe-mode 0)

(xterm-mouse-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)

(column-number-mode 1)
(line-number-mode 1)
(transient-mark-mode t)

(set-language-environment "UTF-8")

(show-paren-mode 1)
(setq show-paren-when-point-inside-paren t)

(setq make-backup-files nil)
(setq auto-save-default nil)

(setq-default scroll-conservatively 100)

(setq-default indent-tabs-mode nil)

(setq-default fill-column 80)
(setq-default truncate-lines t)
(add-hook 'text-mode-hook (lambda () (setq truncate-lines nil)))
(add-hook 'text-mode-hook 'auto-fill-mode)

(setq-default display-line-numbers-width 3)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'electric-pair-local-mode)
(add-hook 'makefile-mode
          (lambda ()
            (setq tab-width 2)))

(editorconfig-mode)

(add-to-list 'load-path (concat user-emacs-directory "site-lisp/"))
(add-to-list 'custom-theme-load-path (concat user-emacs-directory "themes/"))

(load-theme 'base2tone-motel t)

(mapc (lambda (path)
        (load-file path))
      (directory-files (concat user-emacs-directory "/conf.d/") t "\.el$"))
