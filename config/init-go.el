(require-package 'go-mode)
(require-package 'golint)
(require-package 'go-eldoc)
(require 'go-mode)
(require 'golint)


(defun my-go-mode-hook ()
  ; Tab width
  (setq tab-width 4)
  ; Whitespace handling
  (setq whitespace-style '(face empty lines-tail trailing))
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command) "go build && go test"))
  (go-eldoc-setup)
)
(add-hook 'go-mode-hook 'my-go-mode-hook)

;; goimports for format and import automation
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

;; flycheck setup
(with-eval-after-load 'flycheck
  (add-to-list 'load-path "~/go/src/github.com/dougm/goflymake")
  (require 'flycheck)
  (require 'go-flycheck))

;; company 
(with-eval-after-load 'company
  (require-package 'company-go)
  (require 'company-go)
  (add-hook 'go-mode-hook (lambda ()
                            (set (make-local-variable 'company-backends) '(company-go)))))
;; auto-complete 
(with-eval-after-load 'auto-complete
  (require-package 'go-autocomplete)
  (require 'auto-complete)
  (require 'go-autocomplete))

;; godef jump
(with-eval-after-load 'evil
  (add-hook 'go-mode-hook (lambda ()
  (local-set-key (kbd "M-.") 'godef-jump))))

(provide 'init-go)
