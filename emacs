; -*-Lisp-*-

;;; Melpa ;;;;
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

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
 '(custom-safe-themes
   (quote
    ("1297a022df4228b81bc0436230f211bad168a117282c20ddcba2db8c6a200743" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "e56f1b1c1daec5dbddc50abd00fcd00f6ce4079f4a7f66052cf16d96412a09a9" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(frame-background-mode (quote dark))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'custom-theme-load-path "~/.emacs.d/color-theme-solarized")
(load-theme 'solarized-dark)

(setq-default indent-tabs-mode nil)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(global-auto-revert-mode t)

(setq sml/theme 'powerline)
(sml/setup)
