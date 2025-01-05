;; Library for basic parsing and encoding data in .ini files  -*- lexical-binding: t -*-

(defun ini:format-value (val)
  "Returns the string representation of VAL."
  (cond
   ((booleanp val)
    (if val "true" "false"))

   ((vectorp val)
    (string-join (mapcar #'ini:format-value val) ","))

   (t (format "%s" val))))

(defun ini:print-field (field)
  (let ((title   (car field))
        (content (cdr field)))
    (cond
     ((consp content)
      (ini:print-section field))

     (t (princ (format "%s=%s\n"
                       title
                       (ini:format-value content)))))))

(defun ini:print-section (pair)
  (let ((title   (car pair))
        (content (cdr pair)))
    (princ (format "[%s]\n" title))
    (mapc #'ini:print-field content)
    (terpri)))

(defun ini:encode (tree)
  (mapc #'ini:print-section tree))

(provide 'ini)
