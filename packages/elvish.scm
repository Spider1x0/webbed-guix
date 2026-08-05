;;; This file contains package definitions for elvish and its missing
;;; dependency go-pkg-nimblebun-works-go-lsp.
;;;
;;; Usage:
;;;   guix build -f elvish.scm
;;;
;;; Or to install directly:
;;;   guix package -f elvish.scm
(define-module (packages elvish))
(use-modules (guix packages)
             (guix git-download)
             (guix build-system go)
             ((guix licenses) #:prefix license:)
             (gnu packages golang-xyz)   ; go-golang-org-x-sys, go-golang-org-x-sync, etc.
             (gnu packages golang-build)   ; go-golang-org-x-sys, go-golang-org-x-sync, etc.
             (gnu packages golang-web)   ; go-golang-org-x-sys, go-golang-org-x-sync, etc.
             (gnu packages golang-check) ; go-github-com-google-go-cmp
             (guix gexp))


;;; -----------------------------------------------------------------------
;;; Dependency: go-lsp
;;; This is the only dependency of elvish not yet in Guix mainline.
;;; It is a pure type-definition library — no dependencies of its own.
;;; -----------------------------------------------------------------------

(define-public go-pkg-nimblebun-works-go-lsp
  (package
    (name "go-pkg-nimblebun-works-go-lsp")
    (version "1.1.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nimblebun/go-lsp")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "14hdbk0h85930phnsih5k33dj2qx9b3j4vvsf24g6v3qqjvbp54q"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "pkg.nimblebun.works/go-lsp"
      ;; No tests in this package, it's purely type definitions.
      #:tests? #f))
    (home-page "https://pkg.nimblebun.works/go-lsp")
    (synopsis "Language Server Protocol type definitions for Go")
    (description
     "This package provides type definitions and documentation for the Language
Server Protocol (LSP) specification versions 3.15 and 3.16.  It aims to
provide up-to-date and clear definitions for use in Go language server
implementations.")
    (license license:expat)))


;;; -----------------------------------------------------------------------
;;; Main package: elvish
;;;
;;; Notes:
;;; - CGO_ENABLED=0 is set explicitly to produce a fully static binary.
;;;   This avoids the aarch64 linker issue (missing ld/gold) reported on
;;;   the guix-devel mailing list (2024-08-22), and matches the upstream
;;;   recommendation in PACKAGING.md for distro packages.
;;; - #:import-path points to the elvish binary entry point.
;;; - #:unpack-path is needed because the module root is src.elv.sh, not
;;;   the same as the import path.
;;; - inputs (not propagated-inputs) is correct here: elvish is a binary,
;;;   its Go deps don't need to be propagated to dependents.
;;; -----------------------------------------------------------------------

(define-public elvish
  (package
    (name "elvish")
    (version "0.21.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/elves/elvish")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1yrah4xbm8jsmr578676bd0yq1n3dc6ahs0hav6csnl7739jpags"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "src.elv.sh/cmd/elvish"
      #:unpack-path "src.elv.sh"
      ;; Disable CGO for a fully static binary.
      ;; This also avoids the aarch64 gold-linker issue.
      #:phases
      #~(modify-phases %standard-phases
          (add-before 'build 'disable-cgo
            (lambda _
              (setenv "CGO_ENABLED" "0"))))))
    (inputs
     (list go-pkg-nimblebun-works-go-lsp
           go-golang-org-x-sys
           go-golang-org-x-sync
           go-go-etcd-io-bbolt
           go-github-com-sourcegraph-jsonrpc2
           go-github-com-mattn-go-isatty
           go-github-com-google-go-cmp
           go-github-com-creack-pty))
    (home-page "https://elv.sh")
    (synopsis "Expressive programming language and versatile interactive shell")
    (description
     "Elvish is an expressive programming language and a versatile interactive
shell, combined into one package.  It runs on Linux, BSDs, macOS, and Windows.

Key features include:
@itemize
@item Structured pipelines that carry lists, maps, and functions — not just text.
@item Intuitive control structures: @code{if}, @code{for}, @code{while},
and @code{try} with familiar C-like syntax.
@item Directory history backed by a database, accessible with Ctrl-L.
@item Command history search with Ctrl-R.
@item A built-in file manager accessible with Ctrl-N.
@item Exception-based error handling: command failures throw exceptions
and abort execution by default, preventing silent failures.
@item Early variable checking: misspelled variables are caught at
\"compilation\" time before execution.
@end itemize")
    (license license:bsd-2)))

;; Return the elvish package so `guix build -f elvish.scm` works directly.
elvish
