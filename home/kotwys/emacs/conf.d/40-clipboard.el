;; -*- lexical-binding: t -*-
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
   ((string= (getenv "XDG_SESSION_TYPE") "wayland")
    (let ((content (with-temp-buffer
                     (let ((process (make-process
                                     :name "wl-paste"
                                     :buffer (current-buffer)
                                     :sentinel #'ignore
                                     :command '("wl-paste" "-n")
                                     :connection-type '(nil . pipe))))
                       (while (accept-process-output process))
                       (buffer-string)))))
      (insert content)))

   (t
    (message (propertize
              "The session is not a Wayland session."
              'face 'error)))))
