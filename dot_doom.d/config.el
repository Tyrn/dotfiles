;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

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

(map!
 :after evil
 :map evil-window-map
 "C-h" nil)

(with-eval-after-load "ispell"
  (setq ispell-program-name "hunspell")
  (setq ispell-local-dictionary nil)
  (setq ispell-dictionary "en_US,ru_RU,es_ES")
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic "en_US,ru_RU,es_ES"))

;; Projectile settings.
(setq projectile-project-search-path
      '("~/spaces/")
      projectile-sort-order 'recentf)
(setq projectile-track-known-projects-automatically nil)

;; Shortcuts translation.
(use-package reverse-im
  :ensure t
  :custom
  (reverse-im-input-methods '("russian-computer"))
  :config
  (reverse-im-mode t))

;; Org-Roam settings.
(after! org
  (setq org-roam-directory "~/roam/")
  (setq org-roam-index-file "~/roam/index.org"))

;; Instant abbreviations for LaTeX,
;; English and Cyrillic.
;;
;; In case no expansion is needed, example: (H C-S-q H) results in HH.
(defun abbrev-or-insert ()
  (interactive)
  (self-insert-command 1)
  (expand-abbrev))

;; (add-hook 'post-self-insert-hook #'expand-abbrev nil t)

(define-abbrev-table 'global-abbrev-table
  '(
    ("HH" "---~" nil :case-fixed nil :count 0)
    ("РР" "---~" nil :case-fixed nil :count 0)
    ("HJ" "~---" nil :case-fixed nil :count 0)
    ("РО" "~---" nil :case-fixed nil :count 0)
    ("JJ" "~---~" nil :case-fixed nil :count 0)
    ("ОО" "~---~" nil :case-fixed nil :count 0)
    ("ББ" "<<" nil :case-fixed nil :count 0)
    ("ЮЮ" ">>" nil :case-fixed nil :count 0)
    ("LL" "\\ldots{}" nil :case-fixed t :count 0)
    ("ДД" "\\ldots{}" nil :case-fixed t :count 0)
    )
  :regexp (regexp-opt '("HH" "РР" "HJ" "РО" "JJ" "ОО" "ББ" "ЮЮ" "LL" "ДД") t))

(global-set-key (kbd "H") 'abbrev-or-insert)
(global-set-key (kbd "Р") 'abbrev-or-insert)
(global-set-key (kbd "J") 'abbrev-or-insert)
(global-set-key (kbd "О") 'abbrev-or-insert)
(global-set-key (kbd "Б") 'abbrev-or-insert)
(global-set-key (kbd "Ю") 'abbrev-or-insert)
(global-set-key (kbd "L") 'abbrev-or-insert)
(global-set-key (kbd "Д") 'abbrev-or-insert)
