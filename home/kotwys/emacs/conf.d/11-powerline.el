(require 'powerline)
(require 'meow)

(defconst meow-state-names
  '((insert . "入力")
    (normal . "通常")
    (motion . "動き")
    (keypad . "キー")
    (beacon . "狼火")))

(defun powerline-state (&optional face pad)
  (powerline-raw (concat (alist-get meow--current-state
                                    meow-state-names
                                    "不明")
                         " ")
                 face pad))

(setq-default mode-line-format
              '("%e"
                (:eval
                 (let* ((active (powerline-selected-window-active))
                        (mode-face 'tooltip)
                        (mid-face (if active 'powerline-active1 'powerline-inactive1))
                        (right-face1 (if active 'powerline-active2 'powerline-inactive2))
                        (right-face2 (if active 'powerline-active0 'powerline-inactive0))
                        (lhs (list (when active
                                     (powerline-state mode-face 'l))
                                   (powerline-buffer-id mid-face 'r)))
                        (rhs (list (powerline-major-mode mid-face 'l)
                                   (powerline-raw " " mid-face 'l)
                                   (powerline-minor-modes mid-face 'l)
                                   (powerline-raw " " mid-face 'r)
                                   (powerline-raw " %6p" right-face1 'r)
                                   (powerline-raw "%3l" right-face2 'r)
                                   (powerline-raw ":" right-face2 'r)
                                   (powerline-raw "%c" right-face2 'r))))
                   (concat (powerline-render lhs)
                           (powerline-fill mid-face (powerline-width rhs))
                           (powerline-render rhs))))))
