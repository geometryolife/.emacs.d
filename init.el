;; fix wrong warning for v27.2 when use cask
(setq warning-suppress-log-types '((package reinitialization)))
(require 'cask "~/prog/cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)
;; (package-initialize)

;; org 文学编程方式来管理 Emacs 配置文件
;; (require 'org-install)
;;  (require 'ob-tangle)
;;  (org-babel-load-file (expand-file-name "geometryolife.org" user-emacs-directory))


;; 当导入 init-packages 这个包时，会使用 load 函数来加载这个文件，此时是
;; 加载不到的。要使用下面这一句，把 init-packages 的文件路径加到 load-path 中。
;; 提示 load-path 已经包含 ~/.emacs.d 这个目录，重复加载可能会造成错误，
;; 建议使用一个子目录。
;; (add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/lisp")
;; 定义一个函数来快速打开配置文件
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; add more personal func
;; now init-func.el
;; (require 'init-func.el)

;; require -> 检查 -> not exit features -> load -> load-file
(require 'init-packages)
(require 'init-ui)
(require 'init-org)
(require 'init-better-default)
(require 'init-keybindings)


;; load-file, load-path and load 讲解：
;; load-file:
;; 加载一个指定文件。*.el或.elc文件会自动添加，而.gz文件不会。使用这个函数名时，Emacs
;; 不用去猜测文件的扩展名。（这应该能提升性能）
;; load：
;; 使用load来加载一个文件，Emacs会通过 load-path 这个变量来搜索。参数不必提供全路径，例如：
;; (load "undo")。如果.elc文件存在，那么它会先加载，若没有则会加载.el或.gz结尾的文件。
;; 如果事先不知道文件的路径，那么可以使用这个函数。调用load的本质是调用load-file。
;; require：
;; 如果这个某个包还没有被加载，即没有使用autoload加载，就可以使用require来加载。
;; require 会检查 features 变量，如果特性不存在，那么就会调用 load 来从后面的文件加载它。文件名
;; 是根据特性名来猜测的，或者在可选参数中指定。最好用于elisp库或脚本，类似于其它语言的import。
;; provide：
;; 把后面的变量名放到 features 变量中，然后调用 load 来加载 feature。


;; load-file and load
;;(load "init-packages")
;;(load "init-ui")
;;(load "init-better-default")
;;(load "init-keybindings")
;;(load "init-org")

;; (load-file "~/.emacs.d/lisp/init-packages.elc")
;; (load-file "~/.emacs.d/lisp/init-ui.elc")
;;(load-file "~/.emacs.d/lisp/init-better-default.elc")
;; (load-file "~/.emacs.d/lisp/init-org.el")
; (load-file "~/.emacs.d/lisp/init-keybindings.elc")


;; provide 在没有 load 之前，即没有调 load-file 之前，是不会被调用的，只有
;; 在调用了一次 load-file 后，提供 provide 的文件才会一行一行执行。当执行到
;; (provide 'init-xxx) 这句时，在 features 这个变量中才会有 init-xxx 这个 feature。
;; require 依赖 load， load 依赖 load-file
;; rquire 不会因为没有调用 provide 就不工作，实际 require 在查找 features 中没有
;; 某个 feature 后，它会调用 load 来加载，它会使用提供的名字在 load-path 中查找，查找到
;; 这个文件后会先加载.elc文件，没有再加载.el文件，如果都没有，就报错。
;; autoload 是从一个文件中自动加载一个函数。

;; 当调用 autoload 从 test-autoload 的特性或文件名中加载时，就会把 test-autoload 这个函数
;; 变成 autoload 类型的。当第二句调用这个函数时，就会自动 require 指定的文件。下面这个语句可以
;; 使用魔法字符串自动生成。
;; (autoload 'test-autoload "init-better-default")
;; (test-autoload)

;; 自动生成 autoload 文件。
;; (update-file-autoloads "~/.emacs.d/lisp/init-better-default.el" t  "~/.emacs.d/lisp/init-better-default-autoload.el")

;; 执行完这个语句，就相当执行了 (autoload 'test-autoload "init-better-default")，如果再执行 (test-autoload) 这个
;; 函数，如果有 "~/.emacs.d/lisp/init-better-default“ 的el或elc文件就会加载进来。
;; (load "init-better-default-autoload")


;; 把 custom.el 放到 user-emacs-directory 目录下的 lisp 中
;; (setq custom-file "路径")，custom-file是存放用户配置Emacs的自动生成信息的变量名，后面是值
;; expand-file-name 函数用来把相对路径拼接成绝对路径，“路径” 默认目录。
(setq custom-file (expand-file-name "lisp/custom.el" user-emacs-directory))
;; 只有load时才会执行
(load-file custom-file)


;; m-x list-packages => company
;; 使用 Emacs 包管理系统安装的包放在 .emacs.d/elpa 目录里，
;; *.elc 文件是经过Emacs编译后的文件，可以加速访问

;; custom-set-variables 相当于
;; (setq-default company-idle-delay 0.08)

;; 在对象是一个缓冲区局部变量（Buffer-local variable）的时候，比如这里的 cursor-type ，我们
;; 需要区分 setq 与 setq-default ： setq 设置当前缓冲区（Buffer）中的变量值， setq-default 设
;; 置的为全局的变量的值.

;; quote, 它其实就是我们之前常常见到的 ' （单引号）的完全体。 因为它在 Lisp 中十分
;; 常用，所以就提供了简写的方法。
;; 下面两行的效果完全相同的
;; (quote foo)
;; 'foo
;; quote 的意思是不要执行后面的内容，返回它原本的内容（具体请参考下面的例子）
;; (print '(+ 1 1)) ;; -> (+ 1 1)
;; (print (+ 1 1))  ;; -> 2

;; 这样我们就可以区分下面三行代码的区别，
;; 第一种
;; (setq package-selected-packages my/packages)
;; 第二种
;; (setq package-selected-packages 'my/packages)
;; 第三种
;; (setq package-selected-packages (quote my/packages))
;; 第一种设置是在缓冲区中设置一个名为 package-selected-packages 的变量，将其的值
;; 设定为 my/packages 变量的值。第二种和第三种其实是完全相同的，将一个名
;; 为 package-selected-packages 的变量设置为 my/packages 。

;; 在这里我们需要知道 auto-mode-alist 的作用，这个变量是一个 AssociationList，它
;; 使用正则表达式（REGEXP）的规则来匹配不同类型文件应使用的 Major Mode。 下面是几个
;; 正则表达式匹配的例子，
;; (("\\`/tmp/fol/" . text-mode)
;;  ("\\.texinfo\\'" . texinfo-mode)
;;  ("\\.texi\\'" . texinfo-mode)
;;  ("\\.el\\'" . emacs-lisp-mode)
;;  ("\\.c\\'" . c-mode)
;;  ("\\.h\\'" . c-mode)
;;  …)

;; 下面是如何添加新的模式与对应文件类型的例子（与我们配置 js2-mode 时相似的例子），
;; (setq auto-mode-alist
;;   (append
   ;; File name (within directory) starts with a dot.
;;    '(("/\\.[^/]*\\'" . fundamental-mode)
     ;; File name has no dot.
;;     ("/[^\\./]*\\'" . fundamental-mode)
     ;; File name ends in ‘.C’.
;;     ("\\.C\\'" . c++-mode))
;;   auto-mode-alist))

;; Elisp 中并没有命名空间（Namespace），换句话说就是所有的变量均为全局变量，所以其
;; 命名方法就变的非常重要。下面是一个简单的命名规则，

;; #自定义变量可以使用自己的名字作为命名方式（可以是变量名或者函数名）
;; my/XXXX

;; #模式命名规则
;; ModeName-mode

;; #模式内的变量则可以使用
;; ModeName-VariableName
;; 遵守上面的命名规则可以最大程度的减少命名冲突发生的可能性。


;; Major 与 Minor Mode 详解
;; 在这一节我们将详细介绍 Major Mode 与 Minor Mode 去区别。每一个文件类型都对应一
;; 个 Major Mode，它提供语法高亮以及缩进等基本的编辑支持功能，然后而 Minor Mode 则
;; 提供 其余的增强性的功能（例如 linum-mode ）。
;; 在 Emacs 中，Major Mode 又分为三种，
;; text-mode ，用于编辑文本文件
;; special-mode ，特殊模式（很少见）
;; prog-mode ，所有的编程语言的父模式
;;在每一个模式（mode）中它的名称与各个变量还有函数都是有特定的命名规则，比如所有的 模式都被
;; 命名为 ModeName-mode ，里面所设置的快捷键则为 ModeName-mode-key-map ，而所有的钩子则会被
;; 命名为 ModeName-mode-hook 。
;; 比如，目前行号显示是一个全局配置，如果想让一些模式中不显示行号，那么可以使用 hook 特性修改。
