;; 将快速打开配置文件的函数绑定到一个快捷键
(global-set-key (kbd "<f2>") 'open-my-init-file)

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

;; 天气预报函数
;;(defun my/tianqi()
;;  "天气预报 base on https://github.com/chubin/wttr.in"
;;  (interactive)
;;  (eww "zh-cn.wttr.in/yulin?TAFm"))

;; 绑定快捷键查找函数、变量、函数绑定的快捷键在哪个文件中
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)


(global-set-key (kbd "C-c a") 'org-agenda)
;; r aka remember
(global-set-key (kbd "C-c r") 'org-capture)

(global-set-key (kbd "C-c t i") 'my-toggle-web-indent)
(js2r-add-keybindings-with-prefix "C-c C-m")
(global-set-key (kbd "C-=") 'er/expand-region)

;; 绑定和 indent-fuffer 快捷键一样的
(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)

(global-set-key (kbd "s-/") 'hippie-expand)

;; (require 'dired) ;; 都使用 require 加载会变慢，用下面的优化
;; 在加载完 dired 文件后，再执行后面的语句
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

(global-set-key (kbd"M-s o") 'occur-dwim)

(global-set-key (kbd "M-s i") 'counsel-imenu)

(global-set-key (kbd "M-s e") 'iedit-mode)

;; 绑定快捷键为 C-c C-r
(global-set-key "\C-c\ \C-r" 'recentf-open-files)

;; (global-set-key (kbd "C-c p f") 'counsel-git)
;; (global-set-key (kbd "C-c p s") 'helm-do-ag-project-root)

;; 让 C-w 向前删除一个词
(global-set-key (kbd "C-w") 'backward-kill-word)



(provide 'init-keybindings)
