;;; cpanfile-mode.el --- Edit cpanfiles in Emacs
;; Copyright (C) 2016 Zak B. Elep

;;; Package description

;; URL          :       https://github.com/zakame/cpanfile-mode
;; Author       :       Zak B. Elep <zakame@zakame.net>
;; Version      :       0.0.1
;; Date Created :       Mon Sep 26 07:10:33 UTC 2016
;; Keywords     :       perl

;; This file is NOT part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This is a simple helper for editing Perl cpanfile on Emacs, derived
;; from `perl-mode' (or `cperl-mode', if aliased to it.)  Features
;; simple highlighting of cpanfile keywords, and `imenu' lookup.

;;; Code:

(defvar cpanfile-phases
  '("configure" "build" "test" "runtime" "develop")
  "Phases for highlighting in `cpanfile-mode'.")

(defvar cpanfile-keywords
  '("requires" "recommends" "suggests" "conflicts" "on" "feature"
    "configure_requires" "build_requires" "test_requires" "author_requires")
  "Keywords for highlighting in `cpanfile-mode'.")

(defvar cpanfile-font-lock-defaults
  `((("\\s\".*\\s\"" . font-lock-string-face)
     (",\\|;\\|{\\|}\\|=>" . font-lock-keyword-face)
     ( ,(regexp-opt cpanfile-keywords 'words) . font-lock-keyword-face)
     ( ,(regexp-opt cpanfile-phases 'words) . font-lock-constant-face)))
  "Keyword highlighting specification for `cpanfile-mode'.")

(defvar cpanfile-imenu-generic-expression
  '(("Required Packages"
     "^\\s-*\\(requires +\\)\\(\\s\"\\_<.+\\_>\\s\"\\)" 2)
    ("Recommended Packages"
     "^\\s-*\\(recommends +\\)\\(\\s\"\\_<.+\\_>\\s\"\\)" 2))
  "List of `imenu' matchers for `cpanfile-mode'.")

;;;###autoload
(define-derived-mode cpanfile-mode perl-mode "CPANfile"
  "Major mode for editing Perl CPANfiles."

  (setq-local font-lock-defaults cpanfile-font-lock-defaults)
  (setq-local imenu-generic-expression
              cpanfile-imenu-generic-expression)
  (setq-local imenu-create-index-function
              'imenu-default-create-index-function))

(add-to-list 'auto-mode-alist
             '("cpanfile\\'" . cpanfile-mode))

(provide 'cpanfile-mode)

;;; cpanfile-mode.el ends here
