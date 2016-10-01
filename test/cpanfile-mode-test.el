;; cpanfile-mode-test.el --- cpanfile-mode font lock test suite -*- lexical-binding: t; -*-

;;; Commentary:

;; The unit test suite for cpanfile-mode.

;;; Code:

(require 'cpanfile-mode)
(require 'cl-lib)
(require 'ert)

;; utils

(defmacro cpanfile-test-with-temp-buffer (content &rest body)
  "Given CONTENT, Evaluate BODY in a temporary buffer with CONTENT."
  (declare (debug t)
           (indent 1))
  `(with-temp-buffer
     (insert ,content)
     (cpanfile-mode)
     (font-lock-fontify-buffer)
     (goto-char (point-min))
     ,@body))

(defun cpanfile-test-get-face-at-range (start end)
  "Get the face used from START to END."
  (let ((start-face (get-text-property start 'face))
        (all-faces (cl-loop for i from start to end collect (get-text-property i 'face))))
    (if (cl-every (lambda (face) (eq face start-face)) all-faces)
        start-face
      'various-faces)))

(defun cpanfile-test-face-at (start end &optional content)
  "Get the face between START and END in CONTENT.

If CONTENT is not given, return the face at the specified range in the current
buffer."
  (if content
      (cpanfile-test-with-temp-buffer
       content
       (cpanfile-test-get-face-at-range start end))
    cpanfile-test-get-face-at-range start end))

;; font locking tests

(ert-deftest cpanfile-mode-syntax-table/fontify-cpanfile-keyword ()
  :tags '(fontification syntax-table)
  (should (equal (cpanfile-test-face-at 1 7 "requires 'Foo';") font-lock-keyword-face))
  (should (equal (cpanfile-test-face-at 1 10 "recommends 'Bar';") font-lock-keyword-face))
  (should (equal (cpanfile-test-face-at 1 8 "suggests 'Baz';") font-lock-keyword-face))
  (should (equal (cpanfile-test-face-at 1 9 "conflicts 'Quux';") font-lock-keyword-face))
  (should (equal (cpanfile-test-face-at 1 2 "on test") font-lock-keyword-face))
  (should (equal (cpanfile-test-face-at 1 7 "feature 'whizbang'") font-lock-keyword-face)))

(ert-deftest cpanfile-mode-syntax-table/fontify-cpanfile-phases ()
  :tags '(fontification syntax-table)
  (should (equal (cpanfile-test-face-at 1 12 "on configure") 'various-faces))
  (should (equal (cpanfile-test-face-at 1 2 "on configure") font-lock-keyword-face))
  (should (equal (cpanfile-test-face-at 4 12 "on configure") font-lock-constant-face))
  (should (equal (cpanfile-test-face-at 5 13 "on 'configure'") font-lock-string-face)))

(provide 'cpanfile-test)

;;; cpanfile-mode-test.el ends here
