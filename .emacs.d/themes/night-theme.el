;;; night-theme.el --- Custom face theme for Emacs
;;; Commentary:
;;; Author: Nathan Hunzaker
;;; URL: https://github.com/nhunzaker/night-emacs
;;; Version: 0.0.1

;;; Code:
(deftheme night "Inspired by the x-code night theme")

(let ((base00 (if window-system "#111115" "#111111"))
      (base01 (if window-system "#292A44" 'unspecified))
      (base02 "#F1EFF7")
      (base03 "#dd4400")
      (base04 "#ED4781")
      (base05 "#94F2E7")
      (base06 "#7AA5FF")
      (base07 "#666090")
      (base08 "#9DCBFF")
      (base09 "#AE81FF")
      (base10 "#FF6F9F")
      (base11 "#555599" )
      (base12 "#2DE0A7")
      (base13 "#FFBC69")
      (base14 "#a9f")
      (base15 "#E72D2D"))

  (let ((background-color base01)
        (text-color base02)
        (region-color base11)
        (focus-color base02)
        (constant-face base08)
        (comment-color base07)
        (highlight-color base13)
        (builtin-face base06)
        (link-color base06)
        (string-face base13)
        (type-face base12)
        (variable-color base02)
        (params-color base13)
        (function-color base02)
        (keyword-face base06)
        (warning-color base13)
        (error-color base15))

    (custom-theme-set-faces
     'night

     ;; Basics
     `(cursor ((t (:background ,text-color, :foreground unspecified))))
     `(default ((t (:background ,background-color :foreground ,text-color :weight light ))))
     `(isearch ((t (:background ,highlight-color :foreground ,background-color ))))
     `(isearch-fail ((t (:background unspecified :foreground ,error-color))))
     `(match ((t (:background ,focus-color :foreground unspecified))))
     `(menu ((t (:background ,text-color :foreground ,background-color))))
     `(region ((t (:background ,region-color :foreground unspecified))))
     `(warning ((t (:foreground ,warning-color))))

     `(button ((t (:foreground ,link-color))))
     `(link ((t (:underline t))))
     `(link-visited ((t (:underline t))))

     ;; Border above frames and table headings for flycheck
     `(header-line ((t (:background ,background-color :height 100))))

     ;; Highlights
     `(hl-line ((t :background unspecified, :foreground unspecified)))
     `(highlight ((t (:background unspecified :foreground ,highlight-color))))
     `(lazy-highlight ((t (:background unspecified :foreground ,text-color))))

     ;; Mouse
     `(mouse-face ((t (:background ,base01 :foreground ,highlight-color))))

     ;; Search
     `(match ((t (:background ,base01))))

     ;; The Border around the edge of the frame
     `(fringe ((t (:background unspecified :forground unspecified))))
     `(vertical-border ((t (:background unspecified :foreground "#292938"))))
     `(linum ((t (:background "#292938" :foreground "#595987" :height 120 :slant normal :underline nil))))

     `(font-lock-builtin-face ((t (:foreground ,builtin-face :weight normal))))
     `(font-lock-comment-face ((t (:slant italic :foreground ,comment-color))))
     `(font-lock-constant-face ((t (:foreground ,constant-face))))
     `(font-lock-doc-face ((t (:foreground ,comment-color :slant italic))))
     `(font-lock-error-face ((t (:background ,error-color :foreground ,background-color :weight normal))))
     `(font-lock-function-name-face ((t (:foreground ,function-color))))
     `(font-lock-keyword-face ((t (:foreground ,keyword-face :weight light))))
     `(font-lock-preprocessor-face ((t (:foreground ,focus-color ))))
     `(font-lock-string-face ((t (:foreground ,string-face :weight regular ))))
     `(font-lock-type-face ((t (:foreground ,type-face))))
     `(font-lock-variable-name-face ((t (:foreground ,variable-color))))
     `(font-lock-warning-face ((t (:inherit 'warning))))

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
     `(makefile-targets ((t (:foreground ,type-face))))

     ;; Flycheck
     `(flycheck-error ((t (:underline (:color ,error-color :style wave) :bold nil))))
     `(flycheck-fringe-warning ((t (:foreground ,warning-color :bold t))))
     `(flycheck-fringe-error ((t (:foreground ,error-color :bold t))))
     `(flycheck-error-list-highlight ((t ( ))))
     `(flycheck-error-list-checker-name ((t (:foreground "#777") )))

     ;; Flyspell
     `(flyspell-incorrect ((t (:background unspecified :underline (:color ,base03 :style wave) :foreground unspecified))))
     `(flyspell-duplicate ((t (:background: unspecified :foreground unspecified :underline (:color ,base05 :style wave)))))

     ;; white-space mode
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
     `(markdown-header-face-1 ((t (:foreground ,base04))))
     `(markdown-header-face-2 ((t (:foreground ,base04))))
     `(markdown-header-face-3 ((t (:foreground ,base04))))
     `(markdown-header-face-4 ((t (:foreground ,base04))))
     `(markdown-header-face-5 ((t (:foreground ,base04))))
     `(markdown-header-face-6 ((t (:foreground ,base04))))
     `(markdown-bold-face  ((t (:foreground ,base04 :bold t))))
     `(markdown-blockquote-face  ((t (:foreground,comment-color :italic t))))
     `(markdown-pre-face  ((t (:foreground ,base12))))

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
     `(show-paren-mismatch ((t (:background unspecified :foreground ,base13 :underline nil :weight bold))))

     ;; Web Mode ;;
     ;;;;;;;;;;;;;;
     `(web-mode-block-face ((t (:foreground ,text-color, :background unspecified ))))
     `(web-mode-block-delimiter-face ((t (:foreground ,base04, :background unspecified ))))
     `(web-mode-block-control-face ((t (:foreground ,base04, :background unspecified ))))
     `(web-mode-builtin-face ((t (:inherit font-lock-builtin-face))))
     `(web-mode-constant-face ((t (:inherit font-lock-constant-face))))
     `(web-mode-current-element-highlight-face ((t (:foreground ,base04 :background nil))))
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
     `(web-mode-whitespace-face ((t (:foreground ,base03 :background: ,base03))))
     `(web-mode-css-selector-face ((t :inherit css-selector )))
     `(web-mode-css-property-name-face ((t :inherit css-property )))
     `(web-mode-css-variable-color ((t :inherit font-lock-variable-name-face )))
     `(web-mode-css-at-rule-face ((t :inherit font-lock-keyword-face )))
     `(web-mode-css-function-face ((t :inherit font-lock-variable-name-face )))
     `(web-mode-comment-keyword-face ((t :foreground ,base10  )))

     `(js2-external-variable ((t :foreground ,base12)))
     `(js2-warning ((t (:foreground unspecified :background unspecified :underline (:color ,base13 :style wave)))))
     `(js2-error ((t (:foreground unspecified :background unspecified :underline (:color "#402", :style wave)))))
     `(js2-function-param ((t (:foreground ,params-color))))

     `(js2-error ((t (:underline (:color ,warning-color :style wave )))))
     `(js2-function-call ((t :foreground ,text-color)))
     `(js2-jsdoc-tag ((t (:foreground ,base14 :italic t))))
     `(js2-jsdoc-type ((t (:foreground ,base14 :italic t))))
     `(js2-jsdoc-value ((t (:foreground ,base14 :italic t))))

     ;; multi-mark mode
     `(mc/master-face ((t (:inherit 'lazy-highlight))))
     `(mc/region-face ((t (:background ,highlight-color :foreground ,background-color))))

     ;; magit
     `(magit-blame-date ((t (:foreground ,text-color))))
     `(magit-blame-hash ((t (:foreground ,text-color))))
     `(magit-blame-heading ((t (:foreground ,text-color))))
     `(magit-blame-name ((t (:foreground ,text-color))))
     `(magit-blame-summary ((t (:foreground ,text-color))))

     ;;misc
     `(ffap ((t (background: unspecified))))

     ;; org
     `(org-document-title ((t (:foreground ,base04))))
     `(org-todo ((t (:foreground ,base10))))
     `(org-done ((t (:foreground ,base12))))

     `(minibuffer-prompt ((t (:background ,background-color :foreground ,base02 :height 120))))

     `(mode-line-highlight ((t (:background ,base13))))
     `(mode-line-buffer-id ((t (:background unspecified :foreground ,base01))))

     `(mode-line ((t (:background ,base01 :foreground ,base02 :height 100))))
     `(mode-line-inactive ((t (:background ,base01 :foreground ,base11 :height 100))))

     `(org-mode-line-clock ((t (:background unspecified :foreground ,base02))))
     `(org-pomodoro-mode-line ((t (:background unspecified :foreground ,base13))))

     ;; Elixir Mode
     `(elixir-attribute-face ((t (:foreground ,base14))))

     ;; JSDoc minor mode
     `(jsdoc-tags-face ((t (:foreground ,base14))))

     ;; Ocaml (taureg) mode
     `(tuareg-font-lock-governing-face ((t (:inherit ,font-lock-keyword-face))))

     ;; Terminal
     `(term-color-black ((t (:foreground ,comment-color))))
     `(term-color-blue ((t (:foreground ,base10))))
     `(term-color-cyan ((t (:foreground ,base06))))
     `(term-color-green ((t (:foreground ,base12))))
     `(term-color-magenta ((t (:foreground ,base04))))
     `(term-color-red ((t (:foreground ,base03))))
     `(term-color-white ((t (:foreground ,base02))))
     `(term-color-yellow ((t (:foreground ,base13))))
     )))

;;;###autoload
(when load-file-name
  (add-to-list `custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'night)

;;; night-theme.el ends here
