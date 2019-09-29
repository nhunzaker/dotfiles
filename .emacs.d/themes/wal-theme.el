;;; wal-theme.el --- Produces nice color schemes based upon wal output.

;;; Author: Nate Hunzaker
;;; Version: 0.1.0
;;; Package-Requires: ((emacs "24"))

;;; Commentary:
;;; Be sure to install:
;;; https://github.com/dylanaraps/wal

;;; Code:

(deftheme wal
  "Wal color informed color scheme")

(require 'ewal)
(require 'color)

(let ((base00 (ewal-load-color 'black +2))
      (base01 (ewal-load-color 'red +2))
      (base02 (ewal-load-color 'green +2))
      (base03 (ewal-load-color 'yellow +2))
      (base04 (ewal-load-color 'blue +2))
      (base05 (ewal-load-color 'magenta +2))
      (base06 (ewal-load-color 'cyan +2))
      (base07 (ewal-load-color 'white +2))
      (base08 (ewal-load-color 'black +8))
      (base09 (ewal-load-color 'red +8))
      (base10 (ewal-load-color 'green +8))
      (base11 (ewal-load-color 'yellow +8))
      (base12 (ewal-load-color 'blue +8))
      (base13 (ewal-load-color 'magenta +8))
      (base14 (ewal-load-color 'cyan +8))
      (base15 (ewal-load-color 'white +8))

      (gutter (ewal-load-color 'background -8))

      (foreground (ewal-load-color 'foreground))
      (background (ewal-load-color 'background))
      (cursor (ewal-load-color 'background +1.5)))

  (let ((background-color background)
        (foreground-color foreground)
        (gutter-color gutter)
        (text-color foreground)
        (region-color cursor)
        (focus-color foreground)
        (cursor-color cursor)
        (link-color base04)

        (variable-color foreground)
        (function-color foreground)

        (constant-face
         (color-lighten-name
          (color-saturate-name base03 -5)
          20))

        ;; Comments should be a bit lighter than the background and
        ;; completely desaturated
        (comment-color
         (color-lighten-name
          (color-desaturate-name background 100) 35))

        ;; The highlight color should be a complement to the primary
        ;; color. It shows highlights, so it should always stand out!
        (highlight-color
         (color-saturate-name
          (color-complement-hex base01) 20))

        ;; Built-ins should stand out so that they're easy to find.
        ;; Let's make them a little brighter
        (builtin-face
         (color-complement-hex
          (color-lighten-name base02 10)))

        ;; Similar to highlights, strings should also stand out They
        ;; are also often placed next to built-ins, so make a
        ;; complementing color to them.
        (string-face
         (color-saturate-name
          (color-complement-hex base04) 5))

        ;; I don't really have a great reason for this right now, this
        ;; just looks nice for my current wallpaper
        (type-face
         (color-saturate-name
          (color-complement-hex
           (color-lighten-name base01 4))
          20))

        ;; Keywords are fine to keep a bit muted. They show up everywhere
        (keyword-face
         (color-lighten-name
          (color-saturate-name base04 10)
          5))

        (warning-color base11)

        ;; Let's make sure attributes, used for things like tags in
        ;; Elixir, are nice and bright.
        (attribute-color
         (color-saturate-name base13 20))

        ;; I don't quite know what to do here.  Maybe I could get the
        ;; S/L from the primary color and flip the hue to red
        ;;
        ;; For now, I just make it a call out and saturate it a lot
        (error-color
         (color-saturate-name
          (color-complement-hex base01) 50)))

    (custom-theme-set-faces
     'wal

     ;; Basics
     `(cursor ((t (:background ,region-color))))
     `(default ((t (:background ,background-color :foreground ,text-color :weight light))))
     `(isearch ((t (:background ,highlight-color :foreground ,background-color))))
     `(isearch-fail ((t (:background unspecified :foreground ,error-color))))
     `(match ((t (:background ,focus-color :foreground unspecified))))
     `(menu ((t (:background ,text-color :foreground ,background-color))))
     `(region ((t (:background ,region-color :foreground unspecified))))
     `(warning ((t (:foreground ,warning-color))))
     `(button ((t (:foreground ,link-color))))
     `(link ((t (:underline t :foreground ,link-color))))
     `(link-visited ((t (:underline t))))
     `(bold ((t :weight medium)))
     `(italic ((t :slant italic)))
     `(bold-italic ((t :inherit bold :inherit italic)))
     `(alert-low-face ((t :foreground ,link-color)))

     `(comint-highlight-input ((t :foreground ,link-color)))
     `(comint-highlight-prompt ((t :foreground ,link-color)))

     `(minibuffer-prompt ((t :foreground ,base04)))

     ;; Border above frames and table headings for flycheck
     `(header-line ((t (:background ,background-color :height 100))))

     ;; Highlights
     `(hl-line ((t :background unspecified, :foreground unspecified)))
     `(highlight ((t (:background unspecified :foreground ,highlight-color))))
     `(lazy-highlight ((t (:background unspecified :foreground ,text-color))))

     ;; Mouse
     `(mouse-face ((t (:background ,background-color :foreground ,highlight-color))))

     ;; Search
     `(match ((t (:background ,background-color))))

     ;; The Border around the edge of the frame
     `(fringe ((t (:background unspecified :foreground unspecified))))
     `(vertical-border ((t (:background unspecified :foreground ,gutter-color))))

     `(line-number ((t (:background ,gutter-color :foreground ,base08 :height 100 :slant normal :underline nil))))
     `(line-number-current-line ((t (:background ,gutter-color :foreground ,base13 :height 100 :slant normal :underline nil))))
     `(linum ((t (:background ,gutter-color :foreground ,base08 :height 100 :slant normal :underline nil))))

     `(font-lock-builtin-face ((t (:foreground ,builtin-face :weight normal))))
     `(font-lock-comment-face ((t (:foreground ,comment-color :slant italic))))
     `(font-lock-comment-delimiter-face ((t (:inherit font-lock-comment-face :foreground ,comment-color))))
     `(font-lock-constant-face ((t (:foreground ,constant-face))))
     `(font-lock-doc-face ((t (:inherit font-lock-comment-face))))
     `(font-lock-error-face ((t (:background ,error-color :foreground ,background-color :weight normal))))
     `(font-lock-function-name-face ((t (:foreground ,function-color))))
     `(font-lock-keyword-face ((t (:foreground ,keyword-face :weight light :slant italic))))
     `(font-lock-preprocessor-face ((t (:foreground ,focus-color ))))
     `(font-lock-string-face ((t (:foreground ,string-face :weight light))))
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
     `(flx-highlight-face ((t (:foreground ,base04 :background unspecified))))

     ;; Makefile
     `(makefile-targets ((t (:foreground ,type-face))))

     ;; Flycheck
     `(flycheck-error ((t (:background ,error-color :foreground ,background-color :bold nil))))
     `(flycheck-fringe-warning ((t (:foreground ,warning-color :bold t))))
     `(flycheck-fringe-error ((t (:foreground ,error-color :bold t))))
     `(flycheck-error-list-highlight ((t ( ))))
     `(flycheck-error-list-checker-name ((t (:foreground ,base15) )))

     ;; Flyspell
     `(flyspell-incorrect ((t (:background unspecified :underline (:color ,base03 :style wave) :foreground unspecified))))
     `(flyspell-duplicate ((t (:background: unspecified :foreground unspecified :underline (:color ,base10 :style wave)))))

     ;; white-space mode
     `(whitespace-tab ((t (:background nil :foreground ,background-color :underline t))))
     `(whitespace-indentation ((t (:background nil :foreground ,background-color ))))
     `(whitespace-empty ((t (:background unspecified :foreground unspecified :underline t))))
     `(trailing-whitespace ((t (:background ,base03 :foreground ,background-color))))
     `(whitespace-trailing ((t (:background ,base03 :foreground ,background-color))))
     `(whitespace-line ((t (:background unspecified :foreground unspecified :underline t))))

     ;; YAML
     `(yaml-tab-face ((t (:background ,base03 :foreground ,background-color))))

     ;; CSS Mode
     `(css-selector ((t (:foreground ,base09 ))))
     `(css-property ((t (:foreground ,base04 ))))
     `(css-proprietary-property ((t (:foreground ,text-color :italic t))))
     `(scss-variable-color ((t (:foreground ,base12))))
     `(scss-keyword-face ((t (:foreground ,keyword-face ))))

     ;; Markdown Mode
     `(markdown-header-face   ((t (:foreground ,base04))))
     `(markdown-header-face-1 ((t (:foreground ,base09))))
     `(markdown-header-face-2 ((t (:foreground ,base09))))
     `(markdown-header-face-3 ((t (:foreground ,base09))))
     `(markdown-header-face-4 ((t (:foreground ,base09))))
     `(markdown-header-face-5 ((t (:foreground ,base09))))
     `(markdown-header-face-6 ((t (:foreground ,base09))))
     `(markdown-bold-face  ((t (:foreground ,base09 :bold t))))
     `(markdown-blockquote-face  ((t (:foreground,comment-color :italic t))))
     `(markdown-pre-face  ((t (:foreground ,base10))))
     `(markdown-code-face ((t (:height: 100))))

     `(show-paren-match ((t (:background unspecified :foreground ,highlight-color :underline nil :weight normal))))
     `(show-paren-mismatch ((t (:background unspecified :foreground ,base03 :underline nil :weight bold))))

     ;; Web Mode
     `(web-mode-block-face ((t (:foreground ,text-color, :background unspecified ))))
     `(web-mode-block-delimiter-face ((t (:foreground ,base09, :background unspecified ))))
     `(web-mode-block-control-face ((t (:foreground ,base09, :background unspecified ))))
     `(web-mode-builtin-face ((t (:inherit font-lock-builtin-face))))
     `(web-mode-constant-face ((t (:inherit font-lock-constant-face))))
     `(web-mode-current-element-highlight-face ((t (:foreground ,base05 :background nil))))
     `(web-mode-current-column-highlight-face ((t (:foreground unspecified :background "#212144"))))
     `(web-mode-folded-face ((t (:foreground unspecified :underline t))))
     `(web-mode-html-attr-equal-face ((t (:foreground ,comment-color ))))
     `(web-mode-html-attr-name-face ((t (:foreground ,comment-color))))
     `(web-mode-html-attr-value-face ((t :inherit font-lock-string-face)))
     `(web-mode-html-tag-bracket-face ((t (:foreground ,base08))))
     `(web-mode-html-tag-face ((t (:foreground ,base13))))
     `(web-mode-keyword-face ((t (:inherit font-lock-keyword-face))))
     `(web-mode-preprocessor-face ((t (:inherit font-lock-preprocessor-face ))))
     `(web-mode-symbol-face ((t (:foreground ,base12 ))))
     `(web-mode-type-face ((t (:inherit font-lock-type-face ))))
     `(web-mode-variable-name-face ((t (:inherit font-lock-variable-color ))))
     `(web-mode-whitespace-face ((t (:foreground ,base03 :background: ,base03))))
     `(web-mode-css-selector-face ((t :inherit css-selector )))
     `(web-mode-css-property-name-face ((t :inherit css-property )))
     `(web-mode-css-pseudo-class-face ((t :foreground ,base12 :slant italic )))
     `(web-mode-css-variable-color ((t :inherit font-lock-variable-name-face )))
     `(web-mode-css-at-rule-face ((t :inherit font-lock-keyword-face )))
     `(web-mode-css-function-face ((t :inherit font-lock-variable-name-face )))
     `(web-mode-comment-keyword-face ((t :inherit font-lock-comment-face)))

     ;; multi-mark mode
     `(mc/master-face ((t (:inherit 'lazy-highlight))))
     `(mc/region-face ((t (:background ,highlight-color :foreground ,background-color))))

     ;; magit
     `(git-commit-summary ((t (:foreground ,base09 :slant italic :height 130))))
     `(git-commit-comment-branch-local ((t (:foreground ,base12 :slant italic))))
     `(git-commit-comment-heading ((t (:foreground ,base13 :slant italic))))
     `(magit-blame-date ((t (:foreground ,text-color))))
     `(magit-blame-hash ((t (:foreground ,text-color))))
     `(magit-blame-heading ((t (:foreground ,text-color))))
     `(magit-blame-name ((t (:foreground ,text-color))))
     `(magit-blame-summary ((t (:foreground ,text-color))))
     `(magit-header-line ((t (:foreground ,base03))))
     `(magit-section-heading ((t (:foreground ,base03))))
     `(magit-sequence-stop ((t (:foreground ,base10))))
     `(magit-sequence-part ((t (:foreground ,base03))))
     `(magit-signature-good ((t (:foreground ,base10))))
     `(magit-signature-untrusted ((t (:foreground ,base10))))
     `(magit-signature-revoked ((t (:foreground ,base13))))
     `(magit-tag ((t (:foreground ,base10))))
     `(magit-branch-remote ((t (:foreground ,base10))))
     `(magit-blame-dimmed ((t (:foreground ,comment-color))))
     `(magit-dimmed ((t (:foreground ,comment-color))))
     `(magit-hash ((t (:foreground ,comment-color))))

     ;;misc
     `(ffap ((t (background: unspecified))))

     ;; org
     `(org-document-title ((t (:foreground ,base09))))
     `(org-todo ((t (:foreground ,base09 :slant italic))))
     `(org-done ((t (:foreground ,base02 :slant italic))))
     `(org-link ((t :underline t)))
     `(org-level-1 ((t (:foreground ,foreground-color :background unspecified :height unspecified))))
     `(org-level-2 ((t (:foreground ,foreground-color :background unspecified))))
     `(org-level-3 ((t (:foreground ,foreground-color :background unspecified))))
     `(org-level-4 ((t (:foreground ,foreground-color :background unspecified))))
     `(org-level-5 ((t (:foreground ,foreground-color :background unspecified))))
     `(org-level-6 ((t (:foreground ,foreground-color :background unspecified))))
     `(org-special-keyword ((t (:foreground ,keyword-face))))
     `(org-document-info-keyword ((t (:foreground ,keyword-face))))
     `(org-date ((t (:foreground ,base03))))
     `(org-agenda-date ((t (:foreground ,base04 :slant italic :height 140))))
     `(org-agenda-date-today ((t (:foreground ,highlight-color :slant italic :height 140))))
     `(org-time-grid ((t (:foreground ,comment-color :slant italic))))
     `(org-scheduled ((t (:foreground ,comment-color))))
     `(org-agenda-done ((t (:slant italic :foreground ,base00))))
     `(org-scheduled-previously ((t (:foreground ,comment-color))))
     `(org-scheduled-today ((t (:foreground ,text-color))))
     `(org-agenda-calendar-event ((t (:foreground ,base05))))
     `(org-agenda-current-time ((t (:foreground ,highlight-color :slant italic))))
     `(org-mode-line-clock ((t (:background unspecified :foreground ,foreground-color))))
     `(org-pomodoro-mode-line ((t (:background unspecified :foreground ,base03))))
     `(org-table ((t (:background unspecified :foreground ,base12))))
     `(org-agenda-structure ((t (:foreground ,base10))))
     `(org-footnote ((t (:foreground ,base13 :underline t))))
     `(org-sexp-date ((t (:foreground ,base13))))
     `(org-formula ((t (:foreground ,base09))))

     ;; mode-line
     `(mode-line-highlight ((t (:foreground ,highlight-color :slant italic))))
     `(mode-line-buffer-id ((t (:background unspecified :foreground unspecified :slant italic))))
     `(mode-line-buffer-id-inactive ((t (:background unspecified :foreground unspecified))))
     `(mode-line-inactive ((t (:background ,gutter-color :foreground ,base08 :weight light :height 110 :box(:line-width 6 :color ,gutter-color)))))
     `(mode-line ((t (:inherit mode-line-inactive :foreground ,text-color))))

     ;; Elixir Mode
     `(elixir-attribute-face ((t (:foreground ,attribute-color))))

     ;; Compilation mode. I use this mostly with projectile
     `(compilation-error ((t (:foreground ,base09))))
     `(compilation-info ((t (:foreground ,base10))))
     `(compilation-line-number ((t (:foreground ,base09))))

     ;; Helm
     `(helm-selection ((t (:foreground ,base03))))
     `(helm-match ((t (:foreground ,base09))))
     `(helm-header ((t (:height 100))))
     `(helm-source-header ((t (:height 120))))
     `(helm-ff-dotted-directory ((t (:background nil :foreground ,base09))))
     `(helm-ff-dotted-symlink-directory ((t (:background nil :foreground ,base09))))
     `(helm-ff-executable ((t (:background nil :foreground ,base10))))
     `(helm-ff-directory ((t (:background nil :foreground ,base09))))
     `(helm-ff-invalid-symlink ((t (:background ,error-color :foreground ,background-color))))
     `(helm-grep-finish ((t (:background nil :foreground ,base10))))
     `(helm-grep-lineno ((t (:background nil :foreground ,base09))))
     `(helm-buffer-directory ((t (:background nil :foreground ,base09))))
     `(helm-buffer-file ((t (:background nil :foreground ,foreground-color :height 100))))
     `(helm-ff-file ((t (:background nil :foreground ,foreground-color :height 110))))
     `(helm-grep-file ((t (:background nil :foreground ,comment-color))))
     `(helm-grep-lineno ((t (:background nil :foreground ,text-color))))
     `(helm-grep-match ((t (:background nil :foreground ,highlight-color))))

     ;; Company
     `(company-preview ((t (:background nil :foreground ,comment-color))))
     `(company-preview-common ((t (:background nil :foreground ,comment-color))))

     ;; cider mode
     `(cider-test-error-face ((t :background ,highlight-color :foreground ,gutter-color)))

     ;; neotree
     `(neo-root-dir-face ((t :foreground ,comment-color)))
     `(neo-dir-link-face ((t :foreground ,base13)))
     `(neo-file-link-face ((t :foreground ,text-color)))
     `(neo-expand-btn-face ((t :foreground ,base01)))
     )))

;;;###autoload
(when load-file-name
  (add-to-list `custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'wal)

;;; wal-theme.el ends here
