;; 增强 package 系统
;; 当版本大于24时，把package管理系统引入
;; 初始化包管理器
;; 把下载源添加到package系统里
(when (>= emacs-major-version 24)
    (require 'package)
    (package-initialize)
    (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
    )
;; 引入cl
(require 'cl)

;;add whatever packages you want here
;; 定义一个package列表，后续会在这个列表中添加更多package
  (defvar geometryolife/packages '(
				   company ;; 补全插件
				   monokai-theme ;; 主题
				   hungry-delete ;; 增强删除功能
				   restart-emacs  ;; 快速重启 Emacs
				   swiper ;; 增强搜索
				   counsel ;; 常用 Emacs 命令的Ivy-enhanced版本的集合。
				   smartparens ;; 智能配对括号等
				   js2-mode ;; 增强js的major-mode
				   nodejs-repl ;; 交互式执行js
				   ;; 修复Mac找不到程序路径
				   exec-path-from-shell
				   )  "Default packages")

;; 将用户明确安装的软件包存储在此处。
;; Emacs 在安装新包时自动提供此变量。
;; “package-autoremove”使用这个变量来决定
;; 不再需要哪些软件包。
;; 您可以使用它在其他机器上（重新）安装软件包
;; 通过运行package-install-selected-packages。
(setq package-selected-packages geometryolife/packages)

;; 定义一个函数，判断列表中的包是否都安装到geometryolife/packages目录中，
(defun geometryolife/packages-installed-p ()
  ;; 通过循环遍历确定，loop for是cl中的写法，要cl依赖
  (loop for pkg in geometryolife/packages
	;; 当有包没安装时，返回nil
        when (not (package-installed-p pkg)) do (return nil)
	;; 如果都安装完了，返回t
          finally (return t)))

;; 如果 COND 产生 nil，则执行 BODY，否则返回 nil
(unless (geometryolife/packages-installed-p)
  ;; 列表中列出的包还没安装就会调用下面的语句来安装
  ;; 打印信息
  (message "%s" "Refreshing package database...")
  ;; 刷新软件源
  (package-refresh-contents)
  ;; dolist 循环列表
    (dolist (pkg geometryolife/packages)
      (when (not (package-installed-p pkg))
	;; 当没有安装时，安装
        (package-install pkg))))

;; 配置让Emacs可以找到可执行程序
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; 引入并设置插件 hungry-delete，更好地优化 <DEL>
(require 'hungry-delete)
(global-hungry-delete-mode)

;; 引入并设置smex，增强M-x
;; (require 'smex) ; Not needed if you use package.el
;; Can be omitted. This might cause a (minimal) delay
;; when Smex is auto-initialized on its first run.
;; 被counsel取代了
;; (smex-initialize)
;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; 设置counsel、swiper
(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
;; (global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;; (global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
;; (global-set-key (kbd "<f1> l") 'counsel-find-library)
;; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
;; (global-set-key (kbd "C-c g") 'counsel-git)
;; (global-set-key (kbd "C-c j") 'counsel-git-grep)
;; (global-set-key (kbd "C-c k") 'counsel-ag)
;; (global-set-key (kbd "C-x l") 'counsel-locate)
;; (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
;; (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;; 配置js2-mode
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))


;; 定义一个位置存放 Agenda （记录工作议程、日常安排）
(setq org-agenda-files '("~/org/gtd.org"))
(global-set-key (kbd "C-c a") 'org-agenda)


;; 加载主题
(load-theme 'monokai t)

;; 禁用菜单栏、工具栏、滚动条
;;(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; 启用禁止启动画面，旧/新
(setq inhibit-splash-screen t)
;;(setq inhibit-startup-screen t)

;; 禁止文件备份
(setq make-backup-files nil)

;; 显示行号
(global-linum-mode t)


;; 定义一个函数来快速打开配置文件
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; 将快速打开配置文件的函数绑定到一个快捷键
(global-set-key (kbd "<f2>") 'open-my-init-file)

;; 天气预报函数
;;(defun my/tianqi()
;;  "天气预报 base on https://github.com/chubin/wttr.in"
;;  (interactive)
;;  (eww "zh-cn.wttr.in/yulin?TAFm"))

;; 绑定快捷键查找函数、变量、函数绑定的快捷键在哪个文件中
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

;; 对 org 中代码块中的代码进行高亮设置，v26.1 默认
(require 'org)
  (setq org-src-fontify-natively t)

;; require 从一个文件中加载特性，如果没有提供文件名，那么默认
;; 会把 require 后的词作为文件名
;; 开启“最进”菜单
(require 'recentf)
;; 1 和 t 等效的，开启的意思
(recentf-mode 1)
;; 设置“最近”打开的最大项目数的变量为25，默认为10			
(setq recentf-max-menu-items 25)
;; 绑定快捷键为 C-c C-r
(global-set-key "\C-c\ \C-r" 'recentf-open-files)

;; 启用删除选择模式后，键入的文本将替换选择
(delete-selection-mode t)

;; ... s TAB 创建一个代码块。通过自定义 org-modules 或将 ‘(require ‘org-tempo)’ 添加
;; 到您的 Emacs init 文件来启用它。或者 C-c C-,，这是9.2+推荐的按键
;; org 9.2 默认禁用 org 模板功能，需要启用
(require 'org-tempo)

;; 让 Emacs 开启时，全屏
(setq  initial-frame-alist (quote ((fullscreen . maximized))))

;; 使用add-hook特性
;; 添加一个钩子到emacs-lisp-mode-hook上
;; 打开elisp文件时，会打开elisp-mode，这个major-mode激活后会运行拥有的所有钩子
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; 输入成对符号时，输入一半匹配另一半
(require 'smartparens-config)
;; (add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
;; 全局启用 smartparens
(smartparens-global-mode t)
;; Always start smartparens mode in js-mode.
;; (add-hook 'js-mode-hook #'smartparens-mode)

;; 高亮当前行
(global-hl-line-mode t)

;; 全局开启 company-mode
(global-company-mode t)

;; M-x list-packages => company
;; 使用 Emacs 包管理系统安装的包放在 .emacs.d/elpa 目录里，
;; *.elc 文件是经过Emacs编译后的文件，可以加速访问
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0.08)
 '(company-minimum-prefix-length 1)
 '(custom-safe-themes
   '("d9646b131c4aa37f01f909fbdd5a9099389518eb68f25277ed19ba99adeb7279" default))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js2-external-variable ((t (:foreground "dark gray")))))

;; custom-set-variables 相当于
;; (setq-default company-idle-delay 0.08)
