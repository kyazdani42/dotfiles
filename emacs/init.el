(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(set-frame-font "Noto Sans Mono 11" nil t)
(defalias 'yes-or-no-p 'y-or-n-p)
(defvar shell "/usr/bin/sh")
(setq
 display-line-numbers 'relative
 inhibit-startup-message t
 vc-follow-symlinks t
 visible-bell 1
 scroll-margin 8
 make-backup-file nil
 auto-save-default nil
 scroll-conservatively 100
 ring-bell-function 'ignore)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package base16-theme
  :init
  (setq
   base16-distinct-fringe-background nil
   base16-highlight-mode-line "box")
  :config
  (load-theme 'base16-material-palenight t)
  (defvar my/theme base16-material-palenight-colors))

;; needed for doom-modeline
;; run all-the-icon-install-fonts
(use-package all-the-icons)

(use-package doom-modeline
  :init
  (setq doom-modeline-height 33)
  (set-face-attribute 'mode-line nil :height 105)
  (set-face-attribute 'mode-line-inactive nil :height 105)
  :config
  (doom-modeline-mode 1))

(use-package neotree)

(use-package evil-leader
  :config
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "p" 'helm-find-files
    "f" 'helm-ag-project-root
    "b" 'helm-buffers-list
    "<SPC>" 'evil-buffer)
  (global-evil-leader-mode))
(global-set-key (kbd "M-x") 'helm-M-x)

(use-package evil-nerd-commenter)
(use-package evil-goggles
  :init
  (setq
   evil-goggles-duration 0.300
   evil-goggles-blocking-duration 0.010
   evil-goggles-enable-paste nil)
  :config
  (evil-goggles-mode))
(use-package evil-surround
  :config
  (global-evil-surround-mode 1))
(use-package evil
  :init
  ;; Set the cursor color based on the evil state
  (setq evil-emacs-state-cursor   `(,(plist-get my/theme :base0A) box)
	evil-motion-state-cursor  `(,(plist-get my/theme :base0A) box)
	evil-normal-state-cursor  `(,(plist-get my/theme :base0A) box)
	evil-visual-state-cursor  `(,(plist-get my/theme :base0A) box)
	evil-insert-state-cursor  `(,(plist-get my/theme :base0A) bar)
	evil-replace-state-cursor `(,(plist-get my/theme :base0A) bar))
  (setq evil-want-C-u-delete nil)
  (setq evil-want-C-u-scroll 1)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-j") 'evil-normal-state)
  (define-key evil-normal-state-map (kbd "C-j") 'evil-normal-state)
  (define-key evil-visual-state-map (kbd "C-j") 'evil-normal-state)

  (define-key evil-insert-state-map (kbd "C-/") 'evilnc-comment-or-uncomment-lines)
  (define-key evil-visual-state-map (kbd "C-/") 'evilnc-comment-or-uncomment-lines)
  (define-key evil-normal-state-map (kbd "C-/") 'evilnc-comment-or-uncomment-lines)

  (define-key evil-insert-state-map (kbd "C-n") 'neotree-toggle)
  (define-key evil-visual-state-map (kbd "C-n") 'neotree-toggle)
  (define-key evil-normal-state-map (kbd "C-n") 'neotree-toggle))

(global-prettify-symbols-mode t)
(global-hl-line-mode 1)
(set-face-foreground 'highlight nil)
(set-face-background 'hl-line "#1c1f2b")

(use-package rust-mode)

(use-package helm)
(use-package helm-ag)

(use-package lsp-mode)

(use-package org)
(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package magit)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (doom-modeline all-the-icons magit org-bullets lsp-mode helm-ag helm rust-mode evil-nerd-commenter evil-leader base16-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
