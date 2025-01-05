;; -*- lexical-binding: t -*-
(require 'dash)

(defun b2t:parse-color (x)
  "Parses the color from X. Returns a vector of red, green and blue channel
   values."
  (let* ((i (string-to-number (cond  ; Some quirks of YAML parsing
                               ((stringp x) x)
                               ((integerp x) (number-to-string x)))
                              16))
         (r (-> i (ash -16) (logand 255)))
         (g (-> i (ash -8)  (logand 255)))
         (b (-> i           (logand 255))))
    (vector r g b)))

(defun b2t:int->color-name (x)
  "Returns a Base2Tone colorname from an ordinal."
  (let ((tone  (ash x -3))
        (shade (logand x 7)))
    (string (+ ?A tone) (+ ?0 shade))))

(defmacro b2t:with-base-colors (table &rest body)
  `(let ,(mapcar (-compose
                  #'(lambda (color)
                      (let ((tbl-key (intern (concat "base" color)))
                            (sym     (intern (concat "b2t:" color))))
                        `(,sym (b2t:parse-color (gethash ',tbl-key ,table)))))
                  #'b2t:int->color-name)
                 (number-sequence 0 31))
     ,@body))

(provide 'base2tone-lib)
