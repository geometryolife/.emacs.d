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

;; update-directory-autoloads 函数会扫描指定目录下的.el文件，检查.el文件中是否含有魔法
;; 注释，如果这个文件有魔法注释，就会自动为它生成 autoload 的语句。
;; 更新目录 DIRS 中 Lisp 文件的自动加载定义。
;; ;;;###autoload
;; (defun test-autoload()
;;   (interactive)
;;   (message "test autoload"))


(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  ;; point-min 获取选中文本的开头，point-max 获取选中文本的结尾
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive) ;; 可以交互式访问（M-x）或者绑定快捷键
  ;; 当执行完 save-excursion 身体内的语句后，会恢复 执行包裹这些语句前 光标所在的位置
  (save-excursion
    (if (region-active-p)
        (progn
	  ;; 下面把选中的文本传给 indent-region 函数
          (indent-region (region-beginning) (region-end))
          (message "Indented selected region."))
      ;; 没有选中的话，就直接调用 indent-buffer
      (progn
        (indent-buffer)
        (message "Indented buffer.")))))

;; 绑定和 indent-fuffer 快捷键一样的
(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)



(provide 'init-better-default)
