(add-hook 'after-init-hook
          (lambda ()
            (global-git-gutter-mode +1)

            (custom-set-variables
             '(git-gutter:modified-sign "▎")
             '(git-gutter:added-sign "▎")
             '(git-gutter:deleted-sign "▁"))

            (set-face-foreground 'git-gutter:added "#5e974e")
            (set-face-foreground 'git-gutter:modified "#6e558a")
            (set-face-foreground 'git-gutter:deleted "#8d2b30")))
