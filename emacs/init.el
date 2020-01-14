(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

(set-frame-font "Noto Sans Mono 11" nil t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(setq display-line-numbers 'relative
      visible-bell 1
      ring-bell-function 'ignore)

(unless (package-installed-p 'evil)
  (package-install 'evil))
(require 'evil)
(evil-mode 1)
(custom-set-variables
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(define-key evil-insert-state-map (kbd "C-j") 'evil-normal-state)
(define-key evil-visual-state-map (kbd "C-j") 'evil-normal-state)

(unless (package-installed-p 'base16-theme)
  (package-install 'base16-theme))
(setq base16-distinct-fringe-background nil
      base16-highlight-mode-line "box")
(load-theme 'base16-material-palenight t)
;; Set the cursor color based on the evil state
(defvar my/base16-colors base16-material-palenight-colors)
(setq evil-emacs-state-cursor   `(,(plist-get my/base16-colors :base0A) box)
      evil-motion-state-cursor  `(,(plist-get my/base16-colors :base0A) box)
      evil-normal-state-cursor  `(,(plist-get my/base16-colors :base0A) box)
      evil-visual-state-cursor  `(,(plist-get my/base16-colors :base0A) box)
      evil-insert-state-cursor  `(,(plist-get my/base16-colors :base0A) bar)
      evil-replace-state-cursor `(,(plist-get my/base16-colors :base0A) bar))

(global-hl-line-mode 1)
(set-face-foreground 'highlight nil)
(set-face-background 'hl-line "#1c1f2b")
