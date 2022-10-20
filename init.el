(load-theme 'deeper-blue t)
(global-display-line-numbers-mode)

;; Startup
; Minimize garbage collection during startup
; (setq gc-cons-threshold most-positive-fixnum)
(defvar file-name-handler-alist-old file-name-handler-alist)

(setq file-name-handler-alist nil
      gc-cons-threshold most-positive-fixnum)

;; Lower threshold to speed up garbage collection
(add-hook 'after-init-hook
          `(lambda ()
             (setq file-name-handler-alist file-name-handler-alist-old)
             (setq gc-cons-threshold (* 2 1000 1000)))
          t)

;; BACKUPS
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups")))
      vc-make-backup-files t
      version-control t
      kept-old-versions 0
      kept-new-versions 10
      delete-old-versions t
      backup-by-copying t)

;; PACKAGE PATHS
(add-to-list 'load-path (concat user-emacs-directory "packages/"))

;; DISABLE GUI COMPONENTS
(tooltip-mode      -1)
(menu-bar-mode     -1)            ;; отключить графическое меню
(tool-bar-mode     -1)            ;; отключить tool-bar
(scroll-bar-mode   -1)            ;; отключить полосу прокрутки
(blink-cursor-mode -1)            ;; курсор не мигает
(setq use-dialog-box     nil)     ;; никаких графических диалогов и окон - все через минибуфер
(setq redisplay-dont-pause t)     ;; лучшая отрисовка буфера
(setq ring-bell-function 'ignore) ;; отключить звуковой сигнал
(setq column-number-mode t)

(global-hl-line-mode t)
(customize-set-value 'modus-themes-org-blocks 'gray-background
                     "Color background of code blocks gray.")

;;; PUILTIN PACKAGES ------------------------------------------------------------
;; IMENU
(require 'imenu)
(setq imenu-auto-rescan      t) ;; автоматически обновлять список функций в буфере
(setq imenu-use-popup-menu nil) ;; диалоги Imenu только в минибуфере
(global-set-key (kbd "<f6>") 'imenu) ;; вызов Imenu на F6

;; CEDET settings
(require 'cedet) ;; использую "вшитую" версию CEDET. Мне хватает...
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-show-parser-state-mode)
(semantic-mode   t)
(global-ede-mode t)
(require 'ede/generic)
(require 'semantic/ia)
(ede-enable-generic-projects)

;; DIRED
(require 'dired)
(setq dired-recursive-deletes 'top) ;; чтобы можно было непустые директории удалять..

;; ORG-MODE SETTINGS
(require 'org) ;; Вызвать org-mode
(global-set-key "\C-ca" 'org-agenda) ;; поределение клавиатурных комбинаций для внутренних
(global-set-key "\C-cb" 'org-iswitchb) ;; подрежимов org-mode
(global-set-key "\C-cl" 'org-store-link)
(add-to-list 'auto-mode-alist '("\\.org$" . Org-mode)) ;; ассоциируем *.org файлы с org-mode

;; IDO PLUGIN
(require 'ido)
(ido-mode                      t)
(icomplete-mode                t)
(ido-everywhere                t)
(setq ido-vitrual-buffers      t)
(setq ido-enable-flex-matching t)

;;; EXTERNAL PACKAGES -----------------------------------------------------------

;(set-face-background 'default "undefined")
;(load "tron-legacy-emacs-theme/tron-legacy-theme")
;(load-theme 'tron-legacy t)
(load "modus-themes/modus-themes")
(load-theme 'modus-vivendi t)

;; Display the name of the current buffer in the title bar
(setq frame-title-format "GNU Emacs: %b")

;; Electric-modes settings
(electric-pair-mode    1) ;; автозакрытие {},[],() с переводом курсора внутрь скобок
(electric-indent-mode -1) ;; отключить индентацию  electric-indent-mod'ом (default in Emacs-24.4)

;; EVIL PLACE -------------------------------------------------------------------
(add-to-list 'load-path (concat user-emacs-directory "packages/evil"))
; dependencies
(load "annalist/annalist")

; evil
(setq evil-want-keybinding nil)
(setq evil-want-C-u-scroll t)
(setq evil-want-Y-yank-to-eol t)
(setq evil-want-fine-undo 'fine)
(setq evil-undo-system 'undo-redo)
(setq evil-want-integration t)

(setq evil-search-module 'evil-search)
(setq evil-disable-insert-state-bindings t)
(setq evil-split-window-below t)
(setq evil-split-window-right t)

(setq scroll-step 1)
(setq scroll-margin 1)

(load "evil/evil")
(load "evil-collection/evil-collection")
(load "evil-surround/evil-surround")

(require 'evil)
(require 'evil-collection)
(require 'evil-surround)

(evil-set-leader 'normal " ")
(evil-collection-init)
(global-evil-surround-mode 1)

(evil-mode 1)

;; SLY
(add-to-list 'load-path (concat user-emacs-directory "packages/sly"))
(load "sly/sly")
(require 'sly)
(setq inferior-lisp-program "/usr/bin/sbcl")
