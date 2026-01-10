;; ~/.emacs.d/init.el
;; ------ Core configurations ------
(display-time-mode t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(set-face-attribute 'default nil :font "Hack-18")

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(global-display-line-numbers-mode t)
(setq column-number-mode t)
;; (global-hl-line-mode t)
(show-paren-mode t)
(setq show-paren-delay 0)
(electric-indent-mode t)
(delete-selection-mode t)

(setq make-backup-files nil)
(setq auto-save-default nil)

(setq gc-cons-threshold 100000000)

;; ------ Package management ------
(require 'package)
(setq package-archives
  '(;;("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
    ;;("gnu"   . "https://mirrors.ustc.edu.cn/elpa/gnu/")
    ;;("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")
    ;;("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
    ;;("gnu"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
    ;;("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
    ("melpa" . "https://melpa.org/packages/") 
    ("gnu"   . "https://elpa.gnu.org/packages/")
    ("nongnu" . "https://elpa.nongnu.org/nongnu/")
    ))

(package-initialize)
(setq package-archive-priorities
      '(("melpa" . 10)
        ("gnu" . 10)
        ("nongnu" . 10)))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(load-theme 'tango-dark t)

;; ------ UI Enhancements ------
(use-package which-key
  :init (which-key-mode)
  :config
  (setq which-key-side-window-location 'bottom
        which-key-side-window-max-height 0.25
        which-key-idle-delay 0.5))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package smartparens
  :init
  (smartparens-global-mode t)
  (show-smartparens-global-mode t))

;; ------ Core Extensions ------
(use-package exec-path-from-shell
  :ensure t
  :init
  (when (daemonp)
    (exec-path-from-shell-initialize))
  :config
  (dolist (var '("PATH" "NVM_DIR" "NODE_PATH"))
    (add-to-list 'exec-path-from-shell-variables var))
  (exec-path-from-shell-initialize))

(use-package company
  :config
  (global-company-mode)
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 2
        company-tooltip-limit 10
        company-show-numbers t
        company-selection-wrap-around t)
  :bind (:map company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous)
         ("<tab>" . company-complete-selection)))

(use-package flycheck
  :init (global-flycheck-mode)
  :config
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  :bind (("C-c e n" . flycheck-next-error)
         ("C-c e p" . flycheck-previous-error)))

(use-package projectile
  :config (projectile-mode 1)
  :bind-keymap ("C-c p" . projectile-command-map))

(use-package helm
  :config (helm-mode 1)
  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x b" . helm-mini)
         ("C-h a" . helm-apropos)))

(use-package magit
  :bind ("C-x g" . magit-status))

;; ------ Language Server Protocol (LSP) ------
(use-package lsp-mode
  :init (setq lsp-keymap-prefix "C-c l")
  :hook ((python-mode . lsp-deferred)
         (c-mode . lsp-deferred)
         (c++-mode . lsp-deferred)
	 (go-mode . lsp-deferred)
         (js-mode . lsp-deferred)
         (js2-mode . lsp-deferred)
         (typescript-mode . lsp-deferred)
	 (typescript-tsx-mode . lsp-deferred)
	 (tsx-ts-mode . lsp-deferred)
         (web-mode . lsp-deferred))
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-completion-provider :capf
        lsp-idle-delay 0.1
        lsp-enable-symbol-highlighting t
        lsp-log-io nil)
  :bind (:map lsp-mode-map
         ("C-c l d" . lsp-describe-thing-at-point)
         ("C-c l r" . lsp-rename)
         ("C-c l f" . lsp-format-buffer)))

(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-sideline-enable t
        lsp-ui-sideline-show-hover t))

;; ------ Python Configuration ------
(use-package python-mode
  :mode "\\.py\\'"
  :interpreter "python3"
  :hook (python-mode . (lambda ()
                         (setq indent-tabs-mode nil
                               python-indent-offset 4))))

(use-package python-black
  :after python-mode
  :hook (python-mode . python-black-on-save-mode-enable-dwim))

;; ------ Go Configuration ------
(use-package go-mode
  :mode "\\.go\\'"
  :hook ((go-mode . (lambda ()
                      (setq indent-tabs-mode t)
                      (setq tab-width 4))))
  :config
  (setq gofmt-command "goimports"))

;; ------ C/C++ Configuration ------
(add-hook 'c-mode-hook
          (lambda ()
            (setq c-basic-offset 4
                  indent-tabs-mode nil
                  tab-width 4)))

(add-hook 'c++-mode-hook
          (lambda ()
            (setq c-basic-offset 4
                  indent-tabs-mode nil
                  tab-width 4)))

(use-package cmake-mode
  :mode ("\\.cmake\\'" "CMakeLists\\.txt\\'"))

(use-package clang-format
  :hook ((c-mode c++-mode) . (lambda ()
                               (setq clang-format-style "Google")
                               (add-hook 'before-save-hook 'clang-format-buffer nil t))))

(use-package web-mode
  :mode ("\\.html?\\'"
         "\\.css\\'"
         "\\.jsx?\\'"
         "\\.tsx?\\'"
         "\\.vue\\'"
         "\\.svelte\\'")
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-enable-auto-pairing t))

(use-package js2-mode
  :mode "\\.js\\'"
  :interpreter "node"
  :config
  (setq js2-basic-offset 2
        js-indent-level 2)
  :hook (js2-mode . (lambda () (setq indent-tabs-mode nil))))

(use-package typescript-mode
  :ensure t
  :mode "\\.ts\\'"
  :mode "\\.tsx\\'"
  :config
  (setq typescript-indent-level 2))

(use-package json-mode
  :mode "\\.json\\'"
  :config (setq js-indent-level 2))

(use-package prettier-js
  :hook ((js2-mode web-mode json-mode) . prettier-js-mode))

;; ------ Keybindings and Utilities ------
(defun open-init-file ()
  "Open configuration file"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "C-c i") 'open-init-file)

(defun format-buffer ()
  "Format the current buffer using language-specific formatter."
  (interactive)
  (cond
   ((derived-mode-p 'python-mode) (python-black-buffer))
   ((derived-mode-p 'c-mode 'c++-mode) (clang-format-buffer))
   ((derived-mode-p 'go-mode) (gofmt))
   ((derived-mode-p 'web-mode 'js2-mode) (prettier-js))
   (t (indent-region (point-min) (point-max)))))

(global-set-key (kbd "C-c f") 'format-buffer)
(global-set-key (kbd "C-c /") 'comment-line)

(defun run-current-file ()
  "Run the current file based on its extension."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (cond
     ((string-match "\\.py$" file-name)
      (compile (format "python3 %s" file-name)))
     ((string-match "\\.c$" file-name)
      (compile (format "gcc %s -o %s.out && ./%s.out"
                       file-name
                       (file-name-sans-extension file-name)
                       (file-name-sans-extension file-name))))
     ((string-match "\\.cpp$" file-name)
      (compile (format "g++ %s -o %s.out && ./%s.out"
                       file-name
                       (file-name-sans-extension file-name)
                       (file-name-sans-extension file-name))))
     ((string-match "\\.js$" file-name)
      (compile (format "node %s" file-name)))
     ((string-match "\\.go$" file-name)
      (compile (format "go run %s" file-name)))
     (t (message "No runner defined for this file type")))))

(global-set-key (kbd "C-c r") 'run-current-file)

;; ------ Final Setup ------
(setq-default mode-line-format
  '("%e" mode-line-front-space
    mode-line-mule-info
    mode-line-client
    mode-line-modified
    mode-line-remote
    mode-line-frame-identification
    mode-line-buffer-identification
    "   "
    mode-line-position
    "  "
    mode-line-modes
    mode-line-misc-info
    mode-line-end-spaces))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil)
 '(warning-suppress-types '((lsp-mode) (comp))))

(message "Hi, Emacs~")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
