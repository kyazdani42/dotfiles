(set-frame-font "Noto Sans Mono 11" nil t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(setq display-line-numbers 'relative
      visible-bell 1
      ring-bell-function 'ignore)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

(defun installer (pkg)
  (unless (package-installed-p pkg)
    (package-install pkg)))

(installer 'evil)
(require 'evil)
(evil-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (helm lsp-mode rust-mode evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(define-key evil-insert-state-map (kbd "C-j") 'evil-normal-state)
(define-key evil-visual-state-map (kbd "C-j") 'evil-normal-state)

(installer 'base16-theme)
(setq base16-distinct-fringe-background nil
      base16-highlight-mode-line "box")
(load-theme 'base16-material-palenight t)
;; Set the cursor color based on the evil state
(defvar my/colors base16-material-palenight-colors)
(setq evil-emacs-state-cursor   `(,(plist-get my/colors :base0A) box)
      evil-motion-state-cursor  `(,(plist-get my/colors :base0A) box)
      evil-normal-state-cursor  `(,(plist-get my/colors :base0A) box)
      evil-visual-state-cursor  `(,(plist-get my/colors :base0A) box)
      evil-insert-state-cursor  `(,(plist-get my/colors :base0A) bar)
      evil-replace-state-cursor `(,(plist-get my/colors :base0A) bar))

(global-hl-line-mode 1)
(set-face-foreground 'highlight nil)
(set-face-background 'hl-line "#1c1f2b")

(installer 'rust-mode)
(require 'rust-mode)

(installer 'helm)
(require 'helm *.rs)

(installer 'lsp-mode)
(require 'lsp-mode)
