;; -*- lexical-binding: t -*-
(use-package meow
  :defines
  meow-cheatsheet-layout meow-cheatsheet-layout-qwerty
  meow--current-state

  :functions
  meow-global-mode
  meow-motion-define-key
  meow-leader-define-key
  meow-normal-define-key

  :config
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-kill)
   '("D" . meow-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-open-below)
   '("O" . meow-open-above)
   '("p" . meow-yank)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("." . repeat)
   '("/" . meow-visit)
   '("<escape>" . ignore))
  (meow-global-mode 1))

(defconst user--meow-state-name-alist
  '((insert . "入力")
    (normal . "通常")
    (motion . "動き")
    (keypad . "キー")
    (beacon . "狼火")))

(defun user--buffer-status ()
  (let ((is-modified (buffer-modified-p)))
    (cond
     (buffer-read-only "r")
     ((and is-modified (not (eq 'autosaved is-modified))) "+")
     (t nil))))

(use-package powerline
  :demand t
  :after meow
  :functions powerline-raw

  :config
  (defun powerline-state (&optional face pad)
    (powerline-raw
     (concat
      (alist-get meow--current-state user--meow-state-name-alist "不明")
      " ")
     face pad))

  (setq-default
   mode-line-format
   '("%e"
     (:propertize "\u200b" display ((height 1.2)))
     (:eval
      (let* ((active      (powerline-selected-window-active))
             (status      (user--buffer-status))
             (mode-face  '(:background "#e24f32" :foreground "#242323"))
             (mid-face    (if active 'powerline-active1 'powerline-inactive1))
             (right-face1 (if active 'powerline-active2 'powerline-inactive2))
             (right-face2 (if active 'powerline-active0 'powerline-inactive0))
             (lhs         (list (when active
                                  (powerline-state mode-face 'l))
                                (powerline-buffer-id mid-face)
                                (when status
                                  (powerline-raw (concat "[" status "]")
                                                 mid-face 'l))))
             (rhs         (list (powerline-major-mode mid-face 'l)
                                (powerline-raw " " mid-face 'l)
                                (powerline-minor-modes mid-face 'l)
                                (powerline-raw " " mid-face 'r)
                                (powerline-raw " %6p" right-face1 'r)
                                (powerline-raw "%3l" right-face2 'r)
                                (powerline-raw ":" right-face2 'r)
                                (powerline-raw "%c" right-face2 'r))))
        (concat (powerline-render lhs)
                (powerline-fill mid-face (powerline-width rhs))
                (powerline-render rhs)))))))
