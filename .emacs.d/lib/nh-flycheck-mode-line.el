;;; flycheck-mode-line.el --- My mode line flycheck report
;;; Commentary:
;;; Code:

(defun nh/flycheck-lighter (state)
  "Return flycheck information for the given error type STATE.
Source: https://git.io/vQKzv"
  (let* ((counts (flycheck-count-errors flycheck-current-errors))
         (errorp (flycheck-has-current-errors-p state))
         (err (or (cdr (assq state counts)) "?"))
         (running (eq 'running flycheck-last-status-change)))
    (if (or errorp running) (format "•%s" err))))

(defun nh/flycheck-modeline-report ()
  "Reports flycheck errors to my modeline."
  ;; Flycheck info
  ;; https://www.reddit.com/r/emacs/comments/701pzr/flycheck_error_tally_in_custom_mode_line/
  (when (and (bound-and-true-p flycheck-mode)
             (or flycheck-current-errors
                 (eq 'running flycheck-last-status-change)))
    (concat
     (cl-loop for state in '((error . "#FB4933")
                             (warning . "#FABD2F")
                             (info . "#83A598"))
              as lighter = (nh/flycheck-lighter (car state))
              when lighter
              concat (propertize
                      (concat " " lighter)
                      'face `(:foreground ,(cdr state))))
     " ")))

(provide 'nh-flycheck-mode-line)

;;; flycheck-mode-line ends here
