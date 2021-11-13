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

;; 使用add-hook特性
;; 添加一个钩子到emacs-lisp-mode-hook上
;; 打开elisp文件时，会打开elisp-mode，这个major-mode激活后会运行拥有的所有钩子
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; define-advice 类似于cpp的模板，或者c语言的宏，可以生成新的代码。show-paren-function 是
;; 用来高亮括号的函数。我们可以增强函数的功能，但是不用修改函数的代码。
;; 定义一个 fix-show-paren-function 的 define-advice，:around 代表执行的过程中，执行下面
;; 的一段代码。
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  ;; 查找有没有一个括号，如果有括号就直接调用这个函数，如果光标在中间，会先调用 backward-up-list
  (cond ((looking-at-p "\\s(") (funcall fn))
	;; 为了不让光标移动，使用 save-excursion，即调用完backward-up-list，后返回原位
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     ;; funcall 是调用一个函数的意思
	     (funcall fn)))))


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



;; hippie expand is dabbrev expand on steroids
;; 定义一个列表变量，后面的是补全的列表，类似于 company 的后端，从前到后选择。列表中
;; 都是一些函数，会返回一些符号。
(setq hippie-expand-try-functions-list '(try-expand-dabbrev ;; 当前buffer的token
					 try-expand-dabbrev-all-buffers ;; 已打开的buffer的token
					 try-expand-dabbrev-from-kill
					 try-complete-file-name-partially
					 try-complete-file-name
					 try-expand-all-abbrevs
					 try-expand-list
					 try-expand-line
					 try-complete-lisp-symbol-partially
					 try-complete-lisp-symbol))


;; always delete and copy recursively
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)

;; if there is a dired buffer displayed in the next window, use its
;; current subdir, instead of the current subdir of this dired buffer
(setq dired-dwim-target t)

;; dired - reuse current buffer by pressing 'a'
(put 'dired-find-alternate-file 'disabled nil)




;; less typing when Emacs ask you yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;; C-x C-j 直接打开当前文件的 dired-mode。
(require 'dired-x)

;; 跳转到函数的开头，然后向前搜索，搜索到“\r”后，即把dos下的换行符替换成空字符串
(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;; 获得一个显示table。让它不显示，实现应藏dos下的回车换行
(defun hidden-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

;; dwim = do what i mean
(defun occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
            (buffer-substring-no-properties
             (region-beginning)
             (region-end))
          (let ((sym (thing-at-point 'symbol)))
            (when (stringp sym)
              (regexp-quote sym))))
        regexp-history)
  (call-interactively 'occur))


(defun js2-imenu-make-index ()
  (interactive)
  (save-excursion
    ;; (setq imenu-generic-expression '((nil "describe\\(\"\\(.+\\)\"" 1)))
    (imenu--generic-function '(("describe" "\\s-*describe\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
			       ("it" "\\s-*it\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
			       ("test" "\\s-*test\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
			       ("before" "\\s-*before\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
			       ("after" "\\s-*after\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
			       ("Function" "function[ \t]+\\([a-zA-Z0-9_$.]+\\)[ \t]*(" 1)
			       ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
			       ("Function" "^var[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
			       ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*()[ \t]*{" 1)
			       ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*:[ \t]*function[ \t]*(" 1)
			       ("Task" "[. \t]task([ \t]*['\"]\\([^'\"]+\\)" 1)))))
(add-hook 'js2-mode-hook
	  (lambda ()
	    (setq imenu-create-index-function 'js2-imenu-make-index)))



;; (set-language-environment "UTF-8")

(provide 'init-better-default)
