;; 增强 package 系统
;; 当版本大于24时，把package管理系统引入
;; 初始化包管理器
;; 把下载源添加到package系统里
(when (>= emacs-major-version 24)
    ;;(package-initialize)
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
				 popwin ;; 光标追随打开的窗口
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

;; 激活popwin
(require 'popwin)
(popwin-mode t)

;; 输入成对符号时，输入一半匹配另一半
;; 是 autoload，所以不用使用 require
;; 注：虽然视频中不需要require，但是我测试后，在写elisp单引号时，会错误补全
;; 所以我还是加上来了。v27.2
(require 'smartparens-config)
;;(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
;; 全局启用 smartparens
(smartparens-global-mode t)
;; Always start smartparens mode in js-mode.
;; (add-hook 'js-mode-hook #'smartparens-mode)


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

;; 配置js2-mode
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))

;; 全局开启 company-mode
(global-company-mode t) ;; 这是一个autoload命令
;; 在global-company-mode定义的上面有一条魔法注释，使用三个分号，
;; 三个#号加一个autoload关键字来启用autoload的特性。
;; Emacs的解释器会识别执行的。
;;
;; 当Emacs调用 package-initialize 时，首先遍历 packages 的目录，然后遍历找到的每个
;; package，扫描这个包中的所有文件，当遇到文件中有魔法注释的语句时，Emacs就会把
;; 这些语句提取出来放到自动生成的文件—— packageName-autoload 文件中，每次启动
;; Emacs时，就会自动加载这个文件，文件中描述的功能自动生效。所以在使用具有 autoload
;; 特性的命令时，就不必使用 require 来引入。如下面这两行：
;; ;;;###autoload
;; (define-globalized-minor-mode global-company-mode company-mode company-mode-on)



;; 加载主题
(load-theme 'monokai t)

;; provide 后接一个特性名，下面是把 init-packages 这个特性加载到 features 这个变量中
(provide 'init-packages)
