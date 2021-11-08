;; 禁用菜单栏、工具栏、滚动条
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; 禁用自动缩进
(electric-indent-mode -1)

;; 启用禁止启动画面，旧/新
(setq inhibit-splash-screen t)
;;(setq inhibit-startup-screen t)

;; 显示行号
(global-linum-mode t)

;; 将光标变成bar形
;;(setq cursor-type 'bar)
;; 设置 cursor-type 后，默认变为 buffer-local，不会全局生效，
;; 如果变量不是 buffer-local 类型的，那么 setq 和 setq-default 等效
(setq-default cursor-type 'bar)

;; elisp 语法是逆波兰表达式的一个实现
(+ 2 2)
; 计算 2 + 3 * 4
(+ 2 (* 3 4))

;; setq 定义变量
(setq my-name "geometryolife")
;; message 在屏幕底部显示一条消息
(message my-name)

;; 定义一个无参函数
(defun my-func ()
  ;; 让这个函数可以交互式调用
  (interactive)
  ;; my-name 全局有效
  (message "Hello, %s" my-name))

;; 调用定义好的函数
(my-func)

;; 将函数调用绑定到一个快捷键上
;; 全局、键位、函数名
(global-set-key (kbd "<f1>") 'my-func)

;; 定义一个函数来快速打开配置文件
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; 将快速打开配置文件的函数绑定到一个快捷键
(global-set-key (kbd "<f2>") 'open-my-init-file)

;; M-x list-packages => company
;; 使用 Emacs 包管理系统安装的包放在 .emacs.d/elpa 目录里，
;; *.elc 文件是经过Emacs编译后的文件，可以加速访问
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
