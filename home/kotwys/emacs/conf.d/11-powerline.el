(require 'powerline)

(setq powerline-display-buffer-size nil)
(powerline-default-theme)
(when (functionp 'meow-setup-indicator)
  (meow-setup-indicator))
