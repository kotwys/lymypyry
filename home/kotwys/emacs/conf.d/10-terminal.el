;; -*- lexical-binding: t -*-

(when (not window-system)
  (defun custom-scroll-down ()
    (interactive)
    (scroll-down 2))
  (defun custom-scroll-up ()
    (interactive)
    (scroll-up 2))
  (keymap-global-set "<wheel-down>" 'custom-scroll-up)
  (keymap-global-set "<wheel-up>" 'custom-scroll-down)
  (keymap-global-unset "C-<down-mouse-1>")
  (keymap-global-unset "C-<down-mouse-2>")
  (keymap-global-unset "C-<down-mouse-3>")

  (define-key input-decode-map (kbd "M-[ 1 ; 3 D") (kbd "M-<left>"))
  (define-key input-decode-map (kbd "M-[ 1 ; 3 C") (kbd "M-<right>"))
  (define-key input-decode-map (kbd "M-[ 1 ; 5 D") (kbd "C-<left>"))
  (define-key input-decode-map (kbd "M-[ 1 ; 5 C") (kbd "C-<right>")))
