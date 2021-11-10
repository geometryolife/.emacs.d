;; 禁止响铃
(setq ring-bell-function 'ignore)

;; 全局自动回复模式，开启后，文件在其它地方被更改，会自动刷新到Emacs缓冲区
(global-auto-revert-mode t)

;; 命名规范：
;; Emacs 中的变量没有名称空间，即搜有的变量是全局可见的。在一个文件或模块的内部，可访问
;; 全局的变量。为了防止命名冲突，如果自己的变量/函数，可以使用 名字/xxx 来命名变量/函数。例如：
;; geometryolife/xxx ，可以定义一个片段来快速补全自己的名字来方便使用。
(setq-default abbrev-mode t)
  (define-abbrev-table 'global-abbrev-table '(
                                              ;; signature
                                              ("8ge" "geometryolife")
                                              ;; emacs regex
                                              ))

;; 禁止文件备份
(setq make-backup-files nil)
;; 禁止auto-save
(setq auto-save-default nil)

;; 启用删除选择模式后，键入的文本将替换选择
(delete-selection-mode t)


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

;; 使用add-hook特性
;; 添加一个钩子到emacs-lisp-mode-hook上
;; 打开elisp文件时，会打开elisp-mode，这个major-mode激活后会运行拥有的所有钩子
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)


(provide 'init-better-default)
