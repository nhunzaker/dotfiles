;;; ectoplasm-theme.el --- Custom face theme for Emacs
;;; Commentary:
;;; Author: Nathan Hunzaker
;;; URL: https://github.com/nhunzaker/ectoplasm-emacs
;;; Version: 0.0.1

;;; Code:
(deftheme ectoplasm "Spookie color theme")

(let ((base00 (if window-system "#111115" "#111111"))
      (base01 (if window-system "#251b20" 'unspecified))
      (base02 "#f8f8f0")
      (base03 "#dd4400")
      (base04 (if window-system "#FF4150" "#FF2030"))
      (base05 (if window-system "#aaff55" "#22ff00" ))
      (base06 "#BB90FF")
      (base07 (if window-system "#805a55" "#555555"))
      (base08 "#77AAFF")
      (base09 "#ECBC63")
      (base10 (if window-system "#332233" "#333333")))

  (let ((background-color base01)
        (region-color base10)
        (focus-color base02)
        (constant-face base08)
        (comment-color base07)
        (highlight-color base09)
        (text-color base02)
        (builtin-face base06)
        (error-color base03)
        (link-color base06)
        (string-face base05)
        (type-face base08)
        (variable-color base02)
        (function-color base02)
        (keyword-face base04)
        (warning-color base04)
        (error-color base04))

    (custom-theme-set-faces
     'ectoplasm

     ;; Basics
     `(cursor ((t (:background ,text-color, :foreground unspecified))))
     `(highlight ((t (:background unspecified, :foreground ,highlight-color))))
     `(default ((t (:background ,background-color :foreground ,text-color :weight light ))))
     `(isearch ((t (:background ,highlight-color :foreground ,background-color ))))
     `(isearch-fail ((t (:background unspecified :foreground ,error-color))))
     `(match ((t (:background ,focus-color :foreground unspecified))))
     `(menu ((t (:background ,text-color :foreground ,background-color))))
     `(region ((t (:background ,region-color :foreground unspecified))))
     `(warning ((t (:foreground ,warning-color))))
     `(button ((t (:foreground ,link-color :underline t))))
     `(link ((t (:underline t))))
     `(link-visited ((t (:underline t))))

     `(hl-line ((t :background unspecified, :foreground unspecified)))
     `(highlight ((t (:background ,focus-color :foreground unspecified))))
     `(lazy-highlight ((t (:background unspecified :foreground ,text-color))))
     `(mouse-face ((t (:background ,base01 :foreground ,highlight-color))))
     `(match ((t (:background ,base01))))
     `(sp-pair-overlay-face ((t (:background unspecified))))`
     `(minibuffer-prompt ((t (:background ,background-color :foreground ,base02 :height 120))))

     `(mode-line-highlight ((t (:background ,highlight-color))))
     `(mode-line-buffer-id ((t (:background unspecified :foreground unspecified))))

     `(mode-line ((t (:background ,base10 :foreground ,text-color :height 100))))
     `(mode-line-inactive ((t (:background ,background-color :foreground ,comment-color :height 100))))

     ;; The Border around the edge of the frame
     `(fringe ((t (:background ,background-color :forground ,base00))))
     `(vertical-border ((t (:background ,background-color :foreground ,base00))))
     `(linum ((t (:background "#302530" :foreground "#779" :height 100 :slant normal :underline nil))))

     `(font-lock-builtin-face ((t (:foreground ,builtin-face :weight normal))))
     `(font-lock-comment-face ((t (:slant italic :foreground ,comment-color))))
     `(font-lock-constant-face ((t (:foreground ,constant-face))))
     `(font-lock-doc-face ((t (:foreground ,comment-color))))
     `(font-lock-error-face ((t (:background ,error-color :foreground ,background-color :weight normal))))
     `(font-lock-function-name-face ((t (:foreground ,function-color))))
     `(font-lock-keyword-face ((t (:foreground ,keyword-face))))
     `(font-lock-preprocessor-face ((t (:foreground ,focus-color ))))
     `(font-lock-string-face ((t (:foreground ,string-face :weight regular ))))
     `(font-lock-type-face ((t (:foreground ,type-face))))
     `(font-lock-variable-name-face ((t (:foreground ,variable-color))))
     `(font-lock-warning-face ((t (:inherit 'warning))))

     ;; NeoTree
     ;;;;;;;;;
     `(neo-button-face ((t (:foreground ,link-color))))
     `(neo-header-face ((t (:foreground ,comment-color))))

     ;; Interactively do things
     `(ido-first-match ((t (:foreground ,focus-color))))
     `(ido-subdir ((t (:foreground ,focus-color))))
     `(ido-indicator ((t (:background ,base03 :foreground ,highlight-color))))
     `(ido-only-match ((t (:foreground ,string-face))))

     ;; Menus
     `(info-index-match ((t (:background ,text-color :foreground ,background-color))))
     `(info-menu-star ((t (:foreground ,base03))))

     ;; When finding files, this highlights matching
     `(flx-highlight-face ((t (:foreground ,base06 :background unspecified))))

     ;; Makefile
     `(makefile-targets ((t (:foreground ,builtin-face))))

     ;; Errors
     ;;;;;;;;;
     `(flymake-errline  ((t (:inherit 'font-lock-error-face))))
     `(flymake-warnline ((t (:inherit font-lock-warning-face))))
     `(flycheck-error ((t (:underline (:color ,error-color :style wave) :bold t))))
     `(flycheck-fringe-error ((t (:foreground ,error-color :bold t))))
     `(flyspell-incorrect ((t (:background unspecified :underline (:color ,base04 :style wave) :foreground unspecified))))
     `(flyspell-duplicate ((t (:foreground unspecified :underline (:color ,base05 :style wave)))))
     `(flycheck-fringe-warning ((t (:foreground ,warning-color :bold t))))
     `(js2-error ((t (:underline (:color ,warning-color :style wave )))))
     `(js2-function-call ((t :foreground ,text-color)))
     `(js2-jsdoc-tag ((t (:foreground ,base08))))
     `(js2-jsdoc-type ((t (:foreground ,base07))))
     `(js2-jsdoc-value ((t (:foreground ,base07))))
     `(clojure-test-failure-face ((t :inherit `font-lock-error-face)))

     ;; white-space mode
     ;;;;;;;;;;;;;;;;;;;;;
     `(whitespace-tab ((t (:background nil :foreground ,base01, :underline t))))
     `(whitespace-indentation ((t (:background nil :foreground ,base01 ))))
     `(whitespace-empty ((t (:background unspecified :foreground unspecified :underline t))))
     `(trailing-whitespace ((t (:background ,base03 :foreground ,base01))))
     `(whitespace-trailing ((t (:background ,base03 :foreground ,base01))))
     `(whitespace-line ((t (:background unspecified :foreground unspecified :underline t))))

     ;; YAML ;;
     ;;;;;;;;;
     `(yaml-tab-face ((t (:background ,base03 :foreground ,base01))))

     ;; CSS Mode ;;
     ;;;;;;;;;;;;;
     `(css-selector ((t (:foreground ,base04 ))))
     `(css-property ((t (:foreground ,base06 ))))
     `(css-proprietary-property ((t (:foreground ,text-color :italic t))))
     `(scss-variable-color ((t (:foreground ,base08))))
     `(scss-keyword-face ((t (:foreground ,keyword-face ))))

     ;; Markdown Mode ;;
     ;;;;;;;;;;;;;;;;;;
     `(markdown-header-face   ((t (:foreground ,base06))))
     `(markdown-header-face-1 ((t (:foreground ,base06))))
     `(markdown-header-face-2 ((t (:foreground ,base06))))
     `(markdown-header-face-3 ((t (:foreground ,base06))))
     `(markdown-header-face-4 ((t (:foreground ,base06))))
     `(markdown-header-face-5 ((t (:foreground ,base06))))
     `(markdown-header-face-6 ((t (:foreground ,base06))))
     `(markdown-bold-face  ((t (:foreground ,base04 :bold t))))
     `(markdown-blockquote-face  ((t (:foreground,comment-color :italic t))))

     ;; ERC Mode ;;
     ;;;;;;;;;;;;;
     `(bg:erc-color-face0 ((t :background ,base02 :foreground ,background-color)))
     `(bg:erc-color-face1 ((t :background ,base01 :foreground ,text-color)))
     `(bg:erc-color-face3 ((t :background ,base02 :foreground ,background-color)))
     `(bg:erc-color-face4 ((t :background ,base03 :foreground ,background-color)))
     `(bg:erc-color-face5 ((t :background ,base04 :foreground ,background-color)))
     `(bg:erc-color-face6 ((t :background ,keyword-face :foreground ,background-color)))
     `(bg:erc-color-face7 ((t :background ,base04 :foreground ,background-color)))
     `(bg:erc-color-face8 ((t :background ,highlight-color :foreground ,background-color)))
     `(bg:erc-color-face9 ((t :background ,string-face :foreground ,background-color)))
     `(bg:erc-color-face10 ((t :background ,base02 :foreground ,text-color)))
     `(bg:erc-color-face11 ((t :background ,link-color :foreground ,background-color)))
     `(bg:erc-color-face12 ((t :background ,constant-face :foreground ,background-color)))
     `(bg:erc-color-face13 ((t :background ,keyword-face :foreground ,background-color)))
     `(bg:erc-color-face14 ((t :background ,focus-color :foreground ,text-color)))
     `(bg:erc-color-face15 ((t :background ,base02 :foreground ,background-color)))

     `(fg:erc-color-face0 ((t :foreground ,text-color)))
     `(fg:erc-color-face1 ((t :foreground ,base01)))
     `(fg:erc-color-face2 ((t :foreground ,constant-face)))
     `(fg:erc-color-face3 ((t :foreground ,string-face)))
     `(fg:erc-color-face4 ((t :foreground ,base03)))
     `(fg:erc-color-face5 ((t :foreground ,base07)))
     `(fg:erc-color-face6 ((t :foreground ,keyword-face)))
     `(fg:erc-color-face7 ((t :foreground ,base04)))
     `(fg:erc-color-face8 ((t :foreground ,highlight-color)))
     `(fg:erc-color-face9 ((t :foreground ,string-face)))
     `(fg:erc-color-face10 ((t :foreground ,text-color)))
     `(fg:erc-color-face11 ((t :foreground ,link-color)))
     `(fg:erc-color-face12 ((t :foreground ,constant-face)))
     `(fg:erc-color-face13 ((t :foreground ,base04)))
     `(fg:erc-color-face14 ((t :foreground ,text-color)))
     `(fg:erc-color-face15 ((t :foreground ,text-color)))

     `(erc-nick-msg-face ((t (:foreground ,base02))))
     `(erc-current-nick-face ((t (:foreground ,base04))))
     `(erc-direct-msg-face ((t (:foreground ,focus-color))))
     `(erc-default-face ((t (:foreground ,text-color))))
     `(erc-fool-face ((t (:foreground ,constant-face))))
     `(erc-command-indicator-face ((t (:foreground ,base04))))
     `(erc-notice-face ((t (:foreground ,comment-color))))
     `(erc-button ((t (:foreground ,link-color))))
     `(erc-prompt-face ((t (:foreground ,focus-color))))
     `(erc-dangerous-host-face ((t (:background ,error-color :foreground ,background-color :weight bold))))
     `(erc-error-face ((t (:foreground ,error-color :weight bold))))
     `(erc-inverse-face ((t (:background unspecified :foreground unspecified :weight bold))))
     `(erc-input-face ((t (:background unspecified :foreground ,text-color :weight bold))))
     `(erc-keyword-face ((t (:background unspecified :foreground ,string-face :weight bold))))
     `(erc-pal-face ((t (:background unspecified :foreground ,base04 :weight bold))))
     `(erc-timestamp-face ((t (:background unspecified :foreground ,string-face :weight bold))))
     `(erc-nick-default-face ((t (:foreground ,string-face :weight bold))))
     `(show-paren-match ((t (:background unspecified :foreground ,highlight-color :underline nil :weight bold))))

     ;; Web Mode ;;
     ;;;;;;;;;;;;;;
     `(web-mode-block-face ((t (:foreground ,text-color, :background unspecified ))))
     `(web-mode-block-delimiter-face ((t (:foreground ,base04, :background unspecified ))))
     `(web-mode-block-control-face ((t (:foreground ,base04, :background unspecified ))))
     `(web-mode-builtin-face ((t (:inherit font-lock-constant-face ))))
     `(web-mode-constant-face ((t (:inherit font-lock-builtin-face))))
     `(web-mode-current-element-highlight-face ((t (:foreground ,base04 :background nil ))))
     `(web-mode-folded-face ((t (:foreground unspecified :underline t))))
     `(web-mode-html-attr-equal-face ((t (:foreground ,comment-color ))))
     `(web-mode-html-attr-name-face ((t (:foreground ,comment-color ))))
     `(web-mode-html-attr-value-face ((t :inherit font-lock-string-face)))
     `(web-mode-html-tag-bracket-face ((t (:foreground ,base07))))
     `(web-mode-html-tag-face ((t (:foreground ,base02 ))))
     `(web-mode-keyword-face ((t (:inherit font-lock-keyword-face))))
     `(web-mode-preprocessor-face ((t (:inherit font-lock-preprocessor-face ))))
     `(web-mode-symbol-face ((t (:foreground ,base08 ))))
     `(web-mode-type-face ((t (:inherit font-lock-type-face ))))
     `(web-mode-variable-name-face ((t (:inherit font-lock-variable-color ))))
     `(web-mode-whitespace-face ((t (:foreground "red" :background: "red"))))
     `(web-mode-css-selector-face ((t :inherit css-selector )))
     `(web-mode-css-property-name-face ((t :inherit css-property )))
     `(web-mode-css-variable-color ((t :inherit font-lock-variable-name-face )))
     `(web-mode-css-at-rule-face ((t :inherit font-lock-keyword-face )))
     `(web-mode-css-function-face ((t :inerit font-lock-variable-name-face )))

     `(js2-external-variable ((t :foreground ,base06)))
     `(js2-warning ((t (:foreground unspecified :underline t))))
     `(js2-function-param ((t (:foreground ,base09))))

     ;; multi-mark mode
     `(mc/master-face ((t (:inherit 'lazy-highlight))))
     `(mc/region-face ((t (:background ,highlight-color :foreground ,background-color))))

     `(term-color-black ((t (:foreground "#645656"))))
     `(term-color-blue ((t (:foreground "#CB90cD"))))
     `(term-color-cyan ((t (:foreground "#44BDff"))))
     `(term-color-green ((t (:foreground "#a6fa62"))))
     `(term-color-magenta ((t (:foreground "#F34151"))))
     `(term-color-red ((t (:foreground "#E21D26"))))
     `(term-color-white ((t (:foreground "#f8f8f0"))))
     `(term-color-yellow ((t (:foreground "#FF8800"))))
     )))

;;;###autoload
(when load-file-name
  (add-to-list `custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'ectoplasm)

;;; ectoplasm-theme.el ends here
