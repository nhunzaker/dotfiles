;;; mode-line.el --- My mode line
;;; Commentary:
;;; Code:

(require 'nh-flycheck-mode-line)

(defconst NH/RIGHT_PADDING 0)

(defun mode-line-fill-right (face reserve)
  "Return empty space using FACE and leaving RESERVE space on the right."
  (unless reserve
    (setq reserve 20))
  (when (and window-system (eq 'right (get-scroll-bar-mode)))
    (setq reserve (- reserve 0)))
  (propertize " "
              'display `((space :align-to (- (+ right right-fringe right-margin) ,reserve)))
              'face face))

(setq mode-line-align-left
      '((:propertize " %b | %l:%c" face mode-line-buffer-id)))

(setq mode-line-align-right
      '(
        (:eval (nh/flycheck-modeline-report))
        (if org-pomodor-mode-line
            (:eval org-pomodoro-mode-line)
          (:propertize (:eval (symbol-name major-mode)) face mode-line-highlight))
        " "
        ))

(defun reserve-left/middle ()
  "Space left to reserve on the left."
  (/ (length (format-mode-line)) 2))

(defun reserve-middle/right ()
  "Space left to reserve on the right."
  (+ NH/RIGHT_PADDING (length (format-mode-line mode-line-align-right))))

(setq-default mode-line-format (list
                                mode-line-align-left
                                '(:eval (mode-line-fill-right 'mode-line (reserve-middle/right)))
                                mode-line-align-right))

(provide 'mode-line)

;;; mode-line ends here
