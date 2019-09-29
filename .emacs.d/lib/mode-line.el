;;; init.el --- My mode line
;;; Commentary:
;;; Code:

(defconst NH/RIGHT_PADDING 1)

(defun mode-line-fill-right (face reserve)
  "Return empty space using FACE and leaving RESERVE space on the right."
  (unless reserve
    (setq reserve 20))
  (when (and window-system (eq 'right (get-scroll-bar-mode)))
    (setq reserve (- reserve 0)))
  (propertize " "
              'display `((space :align-to (- (+ right right-fringe right-margin) ,reserve)))
              'face face))

(defun mode-line-fill-center (face reserve)
  "Return empty space using FACE to the center of remaining space leaving RESERVE space on the right."
  (unless reserve
    (setq reserve 20))
  (when (and window-system (eq 'right (get-scroll-bar-mode)))
    (setq reserve (- reserve 3)))
  (propertize " "
              'display `((space :align-to (- (+ center (.5 . right-margin)) ,reserve
                                             (.5 . left-margin))))
              'face face))

(setq mode-line-align-left
  '((:propertize " %b | %l:%c" face mode-line-buffer-id)))

(setq mode-line-align-right
  '((:propertize (:eval (symbol-name major-mode)) face mode-line-highlight)))


(defun reserve-left/middle ()
  (/ (length (format-mode-line)) 2))

(defun reserve-middle/right ()
  (+ NH/RIGHT_PADDING (length (format-mode-line mode-line-align-right))))

(setq-default mode-line-format (list
  mode-line-align-left
 '(:eval (mode-line-fill-right 'mode-line (reserve-middle/right)))
  mode-line-align-right))

(provide 'mode-line)
