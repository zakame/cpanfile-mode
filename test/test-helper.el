;;; test-helper.el --- cpanfile-mode unit test setup -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(message "Running tests on Emacs %s" emacs-version)

(let* ((current-file (if load-in-progress load-file-name (buffer-file-name)))
       (source-directory (locate-dominating-file current-file "Cask"))
       (load-prefer-newer t))
  (load (expand-file-name "cpanfile-mode" source-directory)))

(provide 'test-helper)

;;; test-helper.el ends here
