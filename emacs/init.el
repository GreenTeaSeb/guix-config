(with-eval-after-load 'package
  (add-to-list 'package-archives '(("melpa" . "https://melpa.org/packages/")
				   ("gnu" . "https://elpa.gnu.org/packages/")) t))

(setopt initial-major-mode 'fundamental-mode)

(package-initialize)			
(load-file (expand-file-name "options/vim.el" user-emacs-directory))

