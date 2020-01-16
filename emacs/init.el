(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(set-frame-font "Noto Sans Mono 11" nil t)
(setq display-line-numbers 'relative
      inhibit-startup-message t
      vc-follow-symlinks t
      visible-bell 1
      make-backup-file nil
      auto-save-default nil
      scroll-conservatively 100
      ring-bell-function 'ignore)

(defalias 'yes-or-no-p 'y-or-n-p)

(defvar shell "/usr/bin/sh")

(require 'package)
;; not sure what this do
					; (setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

(defun installer (pkg)
  (unless (package-installed-p pkg)
    (package-install pkg)))

(installer 'base16-theme)
(setq base16-distinct-fringe-background nil
      base16-highlight-mode-line "box")
(load-theme 'base16-material-palenight t)
(defvar my/theme base16-material-palenight-colors)

(installer 'projectile)
(require 'projectile)
(projectile-mode +1)

(installer 'evil-leader)
(require 'evil-leader)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key "p" 'projectile-command-map)
; need to make this vim command C-^ or :buffer
(evil-leader/set-key "<SPC>" 'switch-to-prev-buffer)
(global-evil-leader-mode)

(installer 'evil)
;; Set the cursor color based on the evil state
(setq evil-emacs-state-cursor   `(,(plist-get my/theme :base0A) box)
      evil-motion-state-cursor  `(,(plist-get my/theme :base0A) box)
      evil-normal-state-cursor  `(,(plist-get my/theme :base0A) box)
      evil-visual-state-cursor  `(,(plist-get my/theme :base0A) box)
      evil-insert-state-cursor  `(,(plist-get my/theme :base0A) bar)
      evil-replace-state-cursor `(,(plist-get my/theme :base0A) bar))
(setq evil-want-C-u-delete nil)
(setq evil-want-C-u-scroll 1)
(require 'evil)
(evil-mode 1)
(define-key evil-insert-state-map (kbd "C-j") 'evil-normal-state)
(define-key evil-visual-state-map (kbd "C-j") 'evil-normal-state)

(global-prettify-symbols-mode t)
(global-hl-line-mode 1)
(set-face-foreground 'highlight nil)
(set-face-background 'hl-line "#1c1f2b")

(installer 'rust-mode)
(require 'rust-mode)

(installer 'helm)
(require 'helm)

(installer 'lsp-mode)
(require 'lsp-mode)

(installer 'org)
(installer 'org-bullets)
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(installer 'magit)

;; needed for doom-modeline
;; run all-the-icon-install-fonts
(installer 'all-the-icons)
(require 'all-the-icons)

(installer 'doom-modeline)
(require 'doom-modeline)
(doom-modeline-mode 1)
(setq doom-modeline-height 20)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (evil-leader doom-modeline magit org-bullets org-mode helm lsp-mode rust-mode evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
