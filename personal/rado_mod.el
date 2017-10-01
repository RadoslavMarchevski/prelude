;;Company
(require 'company-clang)
(require 'company-c-headers)
(add-hook 'after-init-hook 'global-company-mode)

(add-to-list 'company-backends 'company-c-headers)


;;Helm
(require 'prelude-helm)
(require 'helm-config)
(require 'helm-projectile)

(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-suggested-key-mapping t
 )

;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)

(global-set-key (kbd "C-c p s t") 'helm-gtags-mode)
;;(custom-set-variables
;; '(helm-gtags-prefix-key "\C-t")
;; '(helm-gtags-suggested-key-mapping t))

;;(add-hook 'helm--minor-mode-hook
;;          (lambda () (local-set-key "\C-c \C-v"
;;                                    gt)))

(define-prefix-command 'gtags-map nil 'helm-gtags-prefix-key)

;; key bindings
(define-key gtags-map "g" 'helm-gtags-tags-in-this-function)    ; Hide everything but the top-level headings
(define-key gtags-map "j" 'hide-gtags-dwim)         ; Hide everything but headings (all body lines)


(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "C-c g g") 'helm-gtags-tags-in-this-function)
     (define-key helm-gtags-mode-map (kbd "C-c g j") 'helm-gtags-select)
     (define-key helm-gtags-mode-map (kbd "C-c g .") 'helm-gtags-dwim)
     (define-key helm-gtags-mode-map (kbd "C-c g u") 'helm-gtags-update-tags)
     (define-key helm-gtags-mode-map (kbd "C-c g ,") 'helm-gtags-pop-stack)
     (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
     (define-key helm-gtags-mode-map (kbd "C-c g f") 'helm-gtags-find-tag)
     (define-key helm-gtags-mode-map (kbd "C-c g r") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "C-c g s") 'helm-gtags-find-symbol)
     (define-key helm-gtags-mode-map (kbd "C-c g p") 'helm-gtags-parse-file)
     (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
     (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)))


(require 'sr-speedbar)

(global-set-key (kbd "C-c q") 'sr-speedbar-toggle)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(global-set-key (kbd "s-b") 'helm-buffers-list)
(global-set-key (kbd "s-c") 'helm-command-prefix)

;;Latex
(require 'smartparens-latex)
;; for case
(require 'cl)

(setq-default TeX-engine 'xetex)

;; set XeTeX mode in TeX/LaTeX
(add-hook 'LaTeX-mode-hook
          (lambda()
             (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
             (setq TeX-command-default "XeLaTeX")
             (setq TeX-save-query nil)
             (setq TeX-show-compilation t)))

(add-hook 'TeX-mode-hook
          (lambda () (TeX-fold-mode 1)))  ; Automatically activate TeX-fold-mode.
(add-hook 'TeX-language-en-hook
          (lambda () (ispell-change-dictionary "english")))

(add-hook 'TeX-language-bg-hook
          (lambda () (ispell-change-dictionary "bulgarian")))

(setq ispell-program-name "aspell") ; could be ispell as well, depending on your preferences
(setq ispell-dictionary "english") ; this can obviously be set to any language your spell-checking program supports

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)

;;Configuring outline mode to fold and unfold regions of text
(defun turn-on-outline-minor-mode ()
  (outline-minor-mode 1))

(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
(setq outline-minor-mode-prefix "C-c C-o C-f") ; Or something else
(add-hook 'outline-minor-mode-hook
          (lambda () (local-set-key "\C-c \C-o"
                                    outline-mode-prefix-map)))
;; Outline-minor-mode key map
(define-prefix-command 'cm-map nil 'outline-mode-prefix-map)
;;;; HIDE
(define-key cm-map "q" 'hide-sublevels)    ; Hide everything but the top-level headings
(define-key cm-map "t" 'hide-body)         ; Hide everything but headings (all body lines)
(define-key cm-map "o" 'hide-other)        ; Hide other branches
(define-key cm-map "c" 'hide-entry)        ; Hide this entry's body
(define-key cm-map "l" 'hide-leaves)       ; Hide body lines in this entry and sub-entries
(define-key cm-map "d" 'hide-subtree)      ; Hide everything in this entry and sub-entries
;; SHOW
(define-key cm-map "a" 'show-all)          ; Show (expand) everything
(define-key cm-map "e" 'show-entry)        ; Show this heading's body
(define-key cm-map "i" 'show-children)     ; Show this heading's immediate child sub-headings
(define-key cm-map "k" 'show-branches)     ; Show all sub-headings under this heading
(define-key cm-map "s" 'show-subtree)      ; Show (expand) everything in this heading & below
;; MOVE
(define-key cm-map "u" 'outline-up-heading)                ; Up
(define-key cm-map "n" 'outline-next-visible-heading)      ; Next
(define-key cm-map "p" 'outline-previous-visible-heading)  ; Previous
(define-key cm-map "f" 'outline-forward-same-level)        ; Forward - same level
(define-key cm-map "b" 'outline-backward-same-level)       ; Backward - same level
(global-set-key (kbd "C-c C-o") 'cm-map)

(global-set-key [M-left] 'hide-body)
(global-set-key [M-right] 'show-all)

;;(add-hook 'window-configuration-change-hook
;;          (lambda ()
;;            (when (or (string-equal (buffer-name) "*TeX Help*")
;;                      (string-equal (buffer-name) "*eshell*")
;;                      (string-equal (buffer-name) "*tex-shell*"))
;;              (if (not (eq (window-height) 15))
;;                  (enlarge-window (- 15 (window-height)))))))

;;Setting RefTeX work
(setq reftex-plug-into-AUCTeX t)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

(add-hook 'reftex-load-hook
          (lambda ()
            (setq reftex-section-levels
                  (cons '("poemtitle" . -3) reftex-section-levels))))

(setq reftex-label-alist
      '(("\\poemtitle" ?P "poem:" "\\ref{%s}" nil ("poem" "poemtitle"))))

;; sensible defaults for OS X, other OSes should be covered out-of-the-box
(when (eq system-type 'darwin)
  (setq TeX-view-program-selection
        '((output-dvi "DVI Viewer")
          (output-pdf "PDF Viewer")
          (output-html "HTML Viewer")))

  (setq TeX-view-program-list
        '(("DVI Viewer" "open %o")
          ("PDF Viewer" "open %o")
          ("HTML Viewer" "open %o"))))

(setq TeX-view-program-selection '((output-pdf "Evince") ))

;; ##### Enable synctex correlation. From Okular just press
;; ##### Shift + Left click to go to the good line.
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(setq TeX-source-correlate-method 'synctex)
(setq TeX-source-correlate‌​-mode t)

(defun un-urlify (fname-or-url)
  "A trivial function that replaces a prefix of file:/// with just /."
  (if (string= (substring fname-or-url 0 8) "file:///")
      (substring fname-or-url 7)
    fname-or-url))
(defun th-evince-sync (file linecol &rest ignored)
  (let* ((fname (un-urlify file))
         (buf (find-buffer-visiting fname))
         (line (car linecol))
         (col (cadr linecol)))
    (if (null buf)
        (message "[Synctex]: %s is not opened..." fname)
      (switch-to-buffer buf)
      (goto-line (car linecol))
      (unless (= col -1)
        (move-to-column col)))))

(defvar *dbus-evince-signal* nil)

(defun enable-evince-sync ()
  (require 'dbus)
  (when (and
         (eq window-system 'x)
         (fboundp 'dbus-register-signal))
    (unless *dbus-evince-signal*
      (setf *dbus-evince-signal*
            (dbus-register-signal
             :session nil "/org/gnome/evince/Window/0"
             "org.gnome.evince.Window" "SyncSource"
             'th-evince-sync)))))

(add-hook 'LaTeX-mode-hook 'enable-evince-sync)
