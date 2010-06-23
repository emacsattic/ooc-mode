;;; ooc-mode.el ---
;;
;; Filename: ooc-mode.el
;; Description:
;; Author: James
;; Maintainer:
;; Created: Sat May 29 20:34:29 2010 (-0400)
;; Version:
;; Last-Updated:
;;           By:
;;     Update #: 21
;; URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:
(require 'cc-mode)
(eval-when-compile
  (require 'cc-langs)
  (require 'cc-fonts)

  (c-add-language 'ooc-mode 'c-mode))

(defconst ooc-font-lock-keywords-1 (c-lang-const c-matchers-1 ooc))

(progn
  (c-lang-defconst c-matchers-3
    ooc (append
         (list
          (cons (concat "\\<"
                        (regexp-opt '("class" "cover" "func" "abstract" "from" "this"
                                      "super" "const" "static" "include"
                                      "import" "break" "continue" "fallthrough"
                                      "implement" "override" "if" "else" "for" "while"
                                      "do" "switch" "case" "version" "return" "ctype"
                                      "typedef" "use" "extends" "enum") t)
                        "\\>")
                'font-lock-keyword-face)
          '("\\\([a-zA-Z_][0-9a-zA-Z_]*[\\\!\\\?]?\\\) *:=" 1 font-lock-variable-name-face)
          '("\\\([a-zA-Z_][0-9a-zA-Z_]*[\\\!\\\?]?\\\):" 1 font-lock-function-name-face)
          '("\\\(\(\\\|->\\\|:=?\\\)\\\s*\\\([a-zA-Z_][0-9a-zA-Z_]*[\\\!\\\?]?\\\)" 2 font-lock-type-face))
         (c-lang-const c-matchers-3)))
  (defconst ooc-font-lock-keywords-2 (c-lang-const c-matchers-2 ooc))
  (defconst ooc-font-lock-keywords-3 (c-lang-const c-matchers-3 ooc)))

(c-lang-defconst c-stmt-delim-chars
  ooc "^;{}?:")                         ;these are the defaults
(c-lang-defconst c-stmt-delim-chars-with-comma
  ooc "^;,{}?:")                        ; these are the defaults

;; Lets make all EOL markers equivalent to ';' This variable could have
;; been named _something_ better... its not asm here
(c-lang-defconst c-at-vsemi-p-fn
  ooc (lambda (&optional pos) t))

(defvar ooc-mode-hook nil
  "Hook to be called after `ooc-mode' is called.")

(defvar ooc-mode-map nil "Keymap for `ooc-mode'.")

(defun ooc-mode-make-syntax-table ()
  (let ((table (make-syntax-table c-mode-syntax-table)))
    (modify-syntax-entry ?! "_" table)
    (modify-syntax-entry ?? "_" table)
    table))

(defvar ooc-mode-syntax-table (ooc-mode-make-syntax-table)
  "Syntax table for `ooc-mode'.")

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.ooc\\'" . ooc-mode))

(defun ooc-mode ()
  "Major mode for editing ooc files."
  (interactive)
  (kill-all-local-variables)
  ;; Setup environment things
  (setq major-mode 'ooc-mode)
  (setq mode-name "ooc")
  (c-initialize-cc-mode t)
  (set-syntax-table ooc-mode-syntax-table)
  (use-local-map c-mode-map)
;  (put 'ooc-mode 'c-mode-prefix "ooc-")
  (c-init-language-vars-for 'ooc-mode)
  (c-common-init 'ooc-mode)
  (run-hooks 'c-mode-common-hook)
  (run-hooks 'ooc-mode-hook)
  (c-update-modeline))


(provide 'ooc-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ooc-mode.el ends here
