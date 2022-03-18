;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Stephen Krider"
      user-mail-address "skrider@berkeley.edu")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(toggle-frame-fullscreen)
(evil-force-normal-state)
(add-hook 'LaTeX-mode-hook (lambda () (prettify-symbols-mode)))
(add-hook 'org-mode-hook (lambda () (org-toggle-pretty-entities)))
(add-hook 'org-mode-hook (lambda () (org-cdlatex-mode)))
(add-hook 'org-mode-hook (lambda () (org-display-inline-images)))

"Keybindings"
"CDLaTex"
(map! :desc "cdlatex" :mode org-mode :i "$" 'cdlatex-dollar)
(map! :desc "cdlatex" :mode org-mode :i "(" 'cdlatex-pbb)
(map! :desc "cdlatex" :mode org-mode :i "{" 'cdlatex-pbb)
(map! :desc "cdlatex" :mode org-mode :i "[" 'cdlatex-pbb)
(map! :desc "cdlatex" :mode org-mode :i "|" 'cdlatex-pbb)
(map! :desc "cdlatex" :mode org-mode :i "<" 'cdlatex-pbb)
(map! :desc "cdlatex" :mode org-mode :i "C-c ?" 'cdlatex-command-help)
(map! :desc "cdlatex" :mode org-mode :i "C-c {" 'cdlatex-environment)
(map! :desc "cdlatex" :mode org-mode :i "C-c -" 'cdlatex-item)
(map! :desc "cdlatex" :mode org-mode :i "<tab>" 'cdlatex-tab)
(setq cdlatex-math-modify-prefix "'")
(map! :desc "yas expand" :mode org-mode :i "C-SPC" 'yas-expand)
;;(map! :desc "latex preview" :mode org-mode "F13" 'org-latex-preview)

(setq org-latex-create-formula-image-program 'dvipng)
(setq org-highlight-latex-and-related '(latex))

;; (setq cdlatex-tab-hook (lambda () (call-interactively `yas-expand)))

(add-hook 'LaTeX-mode-hook (lambda () (prettify-symbols-mode)))
(add-hook 'org-mode-hook (lambda () (org-toggle-pretty-entities)))
(add-hook 'org-mode-hook (lambda () (org-cdlatex-mode)))
(add-hook 'org-mode-hook (lambda () (org-display-inline-images)))
(add-hook 'org-mode-hook (lambda () (company-mode -1)))

(setq org-babel-default-header-args:latex '((:results . "file raw") (:exports . "results") (:file-ext . "png") (:output-dir . "ltximg")))

(map! :desc "paste" :g "C-M-v" (lambda () (interactive)
                                 (shell-command "powershell.exe -c get-clipboard")
                                 (insert-buffer "*Shell Command Output*")))

;; (map! :desc "recursive edit" :g "C-r" (lambda () (interactive)
;;                                         (if (minibufferp)
;;                                             (recursive-edit)
;;                                           (evil-redo))))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
