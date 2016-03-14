;;; person.el --- my personal setting SM.

;;; Commentary:

;; ;;selection with a mouse being immediately injected to the kill ring
;; (setq mouse-drag-copy-region t)

;; ;;some customer key-bindings
;; (global-set-key (kbd "C-z") 'undo)

;;; code:
(setq-default initial-scratch-message
              (concat ";; Happy hacking " (or user-login-name "") " - Emacs ♥ you!\n\n"))

;;cancle the whitespace highlight
(setq prelude-whitespace nil)

;;global line number on 
(global-linum-mode)

;;----------------------------------------------------------------------------
;; Allow access from emacsclient
;;----------------------------------------------------------------------------
(require 'server)
(unless (server-running-p)
  (server-start))

(scroll-bar-mode -1)
(desktop-save-mode 1)

(add-to-list 'evil-emacs-state-modes 'org-mode) 

;; ------------------------------------------------------------
;; When spllitting window, show (other-buffer) in the new window
;; copy from purcell's emacs setting
;; copyright at purcell
;; ------------------------------------------------------------
(defun split-window-func-with-other-buffer (split-function)
  (lexical-let ((s-f split-function))
    (lambda ()
      (interactive)
      (funcall s-f)
      (set-window-buffer (next-window) (other-buffer)))))

(global-set-key "\C-x2" (split-window-func-with-other-buffer 'split-window-vertically))
(global-set-key "\C-x3" (split-window-func-with-other-buffer 'split-window-horizontally))

;; ------------------------------------------------------------
;; for evil-mode: changing some keybindings
;; ------------------------------------------------------------
(define-key evil-insert-state-map "\C-e" 'end-of-line)
(define-key evil-insert-state-map "\C-a" 'begin-of-line)
(define-key evil-insert-state-map "\C-f" 'forward-char)
(define-key evil-insert-state-map "\C-b" 'backward-char)
(define-key evil-insert-state-map "\C-n" 'next-line)
(define-key evil-insert-state-map "\C-p" 'previous-line)
(define-key evil-normal-state-map (kbd "TAB") 'evil-undefine)

;; for emacs use under cygwin, to set chinese font
(if (equal system-type 'cygwin)
    (set-fontset-font "fontset-default"
                  'han (font-spec :family "Microsoft Yahei")
                  nil 'prepend))

;;close the annoyed voice of warning
(setq visible-bell t)

;; disable electric-indent-mode because it makes C-j not work well in python mode
;; I'am not sure about the side affect
(electric-indent-mode -1)

(defun evil-undefine ()
  (interactive)
  (let (evil-mode-map-alist)
    (call-interactively (key-binding (this-command-keys)))))

(provide 'personal)

;;; personal.el ends here
