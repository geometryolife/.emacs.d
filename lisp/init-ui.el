;; 禁用菜单栏、工具栏、滚动条
;;(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; 启用禁止启动画面，旧/新
(setq inhibit-splash-screen t)
;;(setq inhibit-startup-screen t)

;; 让 Emacs 开启时，全屏
(setq  initial-frame-alist (quote ((fullscreen . maximized))))

;; 显示行号
(global-linum-mode t)

;; 高亮当前行
(global-hl-line-mode t)

(provide 'init-ui)
