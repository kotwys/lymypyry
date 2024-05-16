(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
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
   '("<escape>" . ignore)))

(require 'meow)
(meow-setup)
(meow-global-mode 1)

(setq meow-cursor-type-normal 'bar)
(setq meow-cursor-type-motion 'bar)
(defun meow--on-exit ()
  (send-string-to-terminal "\e[5 q"))

(defun clipboard-copy (start end)
  "Copy the selected region to the clipboard using wl-copy"
  (interactive "r")
  (cond
   ((not (use-region-p))
    (message (propertize
              "The region is not accessible."
              'face 'error)))
   ((not (string= (getenv "XDG_SESSION_TYPE") "wayland"))
    (message (propertize
              "The session is not a Wayland session."
              'face 'error)))
   (t (let ((process (make-process
                      :name "wl-copy"
                      :buffer nil
                      :command '("wl-copy")
                      :connection-type 'pipe)))
        (process-send-region process start end)
        (process-send-eof process)))))

(defun clipboard-paste ()
  "Pastes the contents of the clipboard at the current point"
  (interactive)
  (cond
   ((not (string= (getenv "XDG_SESSION_TYPE") "wayland"))
    (message (propertize
              "The session is not a Wayland session."
              'face 'error)))
   (t (let ((content (with-temp-buffer
                       (let ((process (make-process
                                       :name "wl-paste"
                                       :buffer (current-buffer)
                                       :sentinel #'ignore
                                       :command '("wl-paste" "-n")
                                       :connection-type '(nil . pipe))))
                         (while (accept-process-output process))
                         (buffer-string)))))
        (insert content)))))
