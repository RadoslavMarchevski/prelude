;; Please note `file-truename' must be used!
(setenv "GTAGSLIBPATH" (concat "/usr/include"
                               ":"
                               "/usr/src/linux/include"
                               ":"
                               (file-truename "~/git/emacs.prelude/")
                               ":"
                               (file-truename "~/git/na62-MyAnalysis/")
                               ":"
                               (file-truename "~/git/na62fw/")
                               ))
(setenv "MAKEOBJDIRPREFIX" (file-truename "~/obj/"))
(setq company-backends '((company-dabbrev-code company-gtags)))

;;Company
(require 'company-clang)
(require 'company-c-headers)
(add-hook 'after-init-hook 'global-company-mode)

(add-to-list 'company-backends 'company-c-headers)

;;Helm
(require 'prelude-helm)
(require 'helm-config)
(require 'helm-projectile)

;;(global-set-key (kbd "C-c p s t") 'helm-gtags-mode)
;;(custom-set-variables
;; '(helm-gtags-prefix-key "\C-t")
;; '(helm-gtags-suggested-key-mapping t))

;;(add-hook 'helm--minor-mode-hook
;;          (lambda () (local-set-key "\C-c \C-v"
;;                                    gt)))



(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-suggested-key-mapping t
 )

(require 'sr-speedbar)

(global-set-key (kbd "C-c q") 'sr-speedbar-toggle)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(global-set-key (kbd "s-b") 'helm-buffers-list)
(global-set-key (kbd "s-c") 'helm-command-prefix)

(require 'helm-gtags)
;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)


(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
     (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
     (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
     (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
     (define-key helm-gtags-mode-map (kbd "C-c d") nil)
     (define-key helm-gtags-mode-map (kbd "C-j") nil)
     (define-key helm-gtags-mode-map (kbd "C-c C-v g") 'helm-gtags-tags-in-this-function)
     (define-key helm-gtags-mode-map (kbd "C-c C-v j") 'helm-gtags-select)
     (define-key helm-gtags-mode-map (kbd "C-c C-v u") 'helm-gtags-ugpdate-tags)
     (define-key helm-gtags-mode-map (kbd "C-c C-v f") 'helm-gtags-find-tag)
     (define-key helm-gtags-mode-map (kbd "C-c C-v r") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "C-c C-v s") 'helm-gtags-find-symbol)
     (define-key helm-gtags-mode-map (kbd "C-c C-v p") 'helm-gtags-parse-file)
     ))
;;;; remove keybinding
;;(define-key minor-mode-map (kbd "C-c c") nil)
;;
;;;; change keybinding
;;(define-key minor-mode-map (kbd "C-c c") (kbd "C-c C-c"))
