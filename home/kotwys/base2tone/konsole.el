;; Base2Tone theme generator for Konsole  -*- lexical-binding: t -*-
(require 'yaml)
(require 'dash)

(let* ((this-dir  (file-name-directory (buffer-file-name)))
       (load-path (append (list this-dir) load-path)))
  (require 'base2tone-lib)
  (require 'ini))

(defun make-color (name main &optional intense faint)
  `((,name                    ("Color" . ,main))
    (,(concat name "Intense") ("Color" . ,(or intense main)))
    (,(concat name "Faint")   ("Color" . ,(or faint main)))))

(defun make-konsole-theme (theme-name colors)
  (let* ((theme-name  (-> theme-name (string-split "-") (cadr)))
         (description (string-join
                       (list "Base2Tone" (capitalize theme-name) "Dark")
                       " ")))
    (b2t:with-base-colors colors
     `(("General"
        ("Description" . ,description)
        ("ColorRandomization" . nil)
        ("Opacity" . 0.85)
        ("Blur" . t)
        ("Wallpaper" . "")
        ("FillStyle" . "Tile")
        ("WallpaperFlipType" . "NoFlip")
        ("WallpaperOpacity" . 1)
        ("Anchor" . [0.5 0.5]))

       ,@(make-color "Background" b2t:A0 b2t:A3)
       ,@(make-color "Foreground" b2t:A6)
       ,@(make-color "Color0"     b2t:A0 b2t:A3)
       ,@(make-color "Color1"     b2t:B2)
       ,@(make-color "Color2"     b2t:D4)
       ,@(make-color "Color3"     b2t:D7)
       ,@(make-color "Color4"     b2t:B3)
       ,@(make-color "Color5"     b2t:D4)
       ,@(make-color "Color6"     b2t:B4)
       ,@(make-color "Color7"     b2t:A6 b2t:B7)))))

(defun generate-theme (config-path)
  (with-temp-buffer
    (insert-file-contents config-path)
    (let* ((c          (yaml-parse-string (buffer-string)))
           (theme-name (gethash 'scheme c)))
      (ini:encode (make-konsole-theme theme-name c)))))
