;;========================================
;; start the emacsserver that listens to emacsclient
(server-start)

;; display line and column position in the "mode" bar
(setq column-number-mode t)

;; use hippie expand:  http://www.emacswiki.org/emacs/HippieExpand
;; (global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key "\M- " 'hippie-expand)

;; make query-replace less annoying to type
(global-set-key "\M-5" 'query-replace)

;; macro and keybinding for going to the last day in my notes
(fset 'goto-last-day
   "\C-[>\C-r=========\C-n")
(global-set-key "\M-6" 'goto-last-day)

;; macro and key binding for creating a date header for today.  e.g.:
;; ==========
;; 2011-10-28
;; ==========
;; This is what the GNU emacs 23.3 app generated on Mac OS X, using insert-kbd-macro
;; (fset 'insert-day-header
;;    [?\C-a ?\C-u ?1 ?0 ?= return ?\C-u ?\M-! ?d ?a ?t ?e ?  ?+ ?% ?Y ?- ?% ?m ?- ?% ?d return ?\C-e return ?\C-u ?1 ?0 ?= return])
;; This is what emacs GNU Emacs 22.1.1 from the shell generated on Mac OS X, using insert-kbd-macro
(fset 'insert-day-header
   "\C-u10=\C-m\C-u\C-[!date +%Y-%m-%d\C-m\C-e\C-m==========\C-m")
(global-set-key "\M-7" 'insert-day-header)


;; add .emacs.d dir to the load-path, so .el files there can be found by emacs.
(require 'cl)
(defvar emacs-directory "~/.emacs.d/"
  "The directory containing the emacs configuration files.")
(pushnew (expand-file-name emacs-directory) load-path)


;; textmate-like snippets
;; bundle version
;; (require 'yasnippet-bundle)
;; My local snippets
;; (setq yas/root-directory "~/.emacs.d/snippets")
;; Load the snippets
;; (yas/load-directory yas/root-directory)
;; non-bundle version
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet-0.6.1c")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets")
(yas/load-directory "~/.emacs.d/snippets")

;; plist files are xml files
(setq auto-mode-alist (cons '("\\.plist$" . xml-mode) auto-mode-alist))

;; markdown-mode
(autoload 'markdown-mode "markdown-mode/markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))

;; setup emacs to use yaml-mode for yaml files
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
;; Unlike python-mode, this mode follows the Emacs convention of not
;; binding the ENTER key to `newline-and-indent'.  To get this
;; behavior, add the key definition to `yaml-mode-hook':
;; (add-hook 'yaml-mode-hook
;;           '(lambda ()
;;              (define-key yaml-mode-map "\C-m" 'newline-and-indent)))


;; setup emacs to use python-mode for .py files.
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode) interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

;; setup emacs to use octave-mode for .m files
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist (cons '("\\.m$" . octave-mode) auto-mode-alist))
(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1))))

;; setup emacs to use haskell-mode for .hs files.
(load "~/.emacs.d/haskell-mode/haskell-site-file")
;;(setq auto-mode-alist (cons '("\\.hs$" . haskell-mode) auto-mode-alist))
;;(setq interpreter-mode-alist (cons '("haskell" . python-mode) interpreter-mode-alist))
;;(autoload 'python-mode "haskell-mode" "Haskell editing mode." t)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;; haskell indentation modes are mutually exclusive.  Only uncomment one.
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)


;; setup emacs to use R-mode for .R files, etc.
;; see http://ess.r-project.org/Manual/ess.html#Installation
(load "~/.emacs.d/ess-5.12/lisp/ess-site")


(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)


;; setup emacs to use ruby-mode for ruby files, god files, etc.
;; see http://www.saltycrane.com/blog/2008/07/notestoself-erb/
;; see http://blog.client9.com/2007/09/ruby-mode-for-emacs.html
;; see http://www.emacswiki.org/emacs/RubyMode
(add-to-list 'load-path "~/.emacs.d/ruby-mode")
(autoload 'ruby-mode "ruby-mode"
    "Mode for editing ruby source files")
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.god$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
(autoload 'run-ruby "inf-ruby"
    "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
    "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
    '(lambda ()
        (inf-ruby-keys)))
;; If you have Emacs 19.2x or older, use rubydb2x                              
(autoload 'rubydb "rubydb3x" "Ruby debugger" t)
;; uncomment the next line if you want syntax highlighting                     
(add-hook 'ruby-mode-hook 'turn-on-font-lock)


;; TABS and SPACES.  WHY?!?
;; Links:
;; http://www.pement.org/emacs_tabs.htm
;; http://www.xemacs.org/Links/tutorials_1.html
;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Init-Examples.html#Init-Examples
;; will this get rid of the pesky tabs?/non-spaces (where a space disappears) that happens when I copy python code from emacs to the orchestra command line?
;; only use spaces in text-mode, not tabs.
;; (setq-default tab-width 4)
;; (setq-default indent-tabs-mode nil)
;; (global-set-key (kbd "TAB") 'tab-to-tab-stop);           # in every mode
;;
;; define TAB to use the tab-to-tab-stop function, which uses the tab-stop-list defined below.
;; tab-stop-list was defined within emacs by doing 'M-x describe-variable<RET> tab-stop-list' and following commands to set the list.
;; this also messes up the smart indenting in xml mode.  but not the smart indenting in python mode.
;; (define-key text-mode-map (kbd "TAB") 'tab-to-tab-stop); # only in text-mode
;;
;; only indent with spaces, not tabs, in every mode.
;; now xml mode uses spaces, not tabs.
(setq-default indent-tabs-mode nil)
;;
;;(add-hook 'text-mode-hook 
;;  '(lambda ()
;;     (setq tab-width 4)
;;     (setq indent-tabs-mode nil)))


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(gud-gdb-command-name "gdb --annotate=1")
 '(large-file-warning-threshold nil)
 ;;'(tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60)))
)
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
