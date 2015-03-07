(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(require 'evil-leader)

(evil-leader/set-leader ",")
(evil-leader/set-key "e" 'find-file
                     "<SPC>" 'switch-to-buffer)

(evil-mode 1)
(global-evil-leader-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(frame-background-mode (quote dark))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'custom-theme-load-path "~/.emacs.d/color-theme-solarized")
(load-theme 'solarized t)

(setq-default indent-tabs-mode nil)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(global-auto-revert-mode t)
