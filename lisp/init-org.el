;; ... s TAB 创建一个代码块。通过自定义 org-modules 或将 ‘(require ‘org-tempo)’ 添加
;; 到您的 Emacs init 文件来启用它。或者 C-c C-,，这是9.2+推荐的按键
;; org 9.2 默认禁用 org 模板功能，需要启用
(require 'org-tempo)

;; 定义一个位置存放 Agenda （记录工作议程、日常安排）
(with-eval-after-load 'org
  (setq org-agenda-files '("~/.emacs.d/gtd.org"))
  ;; 对 org 中代码块中的代码进行高亮设置，v26.1 默认
  ;;(require 'org)
  (setq org-src-fontify-natively t)
  
  (setq org-capture-templates
	'(("t" "Todo" entry (file+headline "~/.emacs.d/gtd.org" "工作安排")
	   "* TODO [#B] %?\n  %i\n"
	   :empty-lines 1)))
  )


(provide 'init-org)
