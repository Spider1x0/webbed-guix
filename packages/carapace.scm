;;; carapace-bin: multi-shell completion engine (bash, zsh, fish, elvish,
;;; nushell, xonsh, ...), plus the Go libraries it needs that are not in
;;; Guix mainline.
;;;
;;; Usage:
;;;   guix build -L ~/webbed-guide carapace-bin
;;;
;;; How Go packages work in Guix (worth knowing before editing this file):
;;; - go-build-system builds in GOPATH mode (GO111MODULE=off).  go.mod and
;;;   go.sum are IGNORED; every Go input's source is merged into one GOPATH
;;;   tree.  So versions are whatever packages you pass in, and two inputs
;;;   that provide the same import path collide.
;;; - Library packages only install their source (there are no compiled Go
;;;   libraries to install).  That is why they use propagated-inputs: a
;;;   library's dependencies must follow it into whatever finally compiles it.
;;; - #:skip-build? #t is for repos with no Go files at their root;
;;;   `go install <import-path>` would fail with "no Go files".
(define-module (packages carapace)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system go)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages golang)        ; go-1.26
  #:use-module (gnu packages golang-build)  ; go-golang-org-x-mod
  #:use-module (gnu packages golang-xyz))   ; cobra, pflag, yaml, toml, ini


;;; -----------------------------------------------------------------------
;;; Forks published under the ORIGINAL import path.
;;;
;;; carapace-bin's go.mod has two `replace` directives:
;;;   github.com/spf13/pflag          => github.com/carapace-sh/carapace-pflag
;;;   github.com/kevinburke/ssh_config => github.com/carapace-sh/ssh_config
;;; Go's `replace` keeps the import path and swaps the code behind it.  The
;;; Guix equivalent: fetch the fork's repo but set #:import-path to the
;;; original path, so the source lands at src/github.com/spf13/pflag.
;;; -----------------------------------------------------------------------

(define-public go-github-com-carapace-sh-carapace-pflag
  (package
    (name "go-github-com-carapace-sh-carapace-pflag")
    (version "1.3.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/carapace-sh/carapace-pflag")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1d34di93q1l1zq7z0k4hig5sky7dnihgxdgr6q9rqrzhdia1rf8x"))))
    (build-system go-build-system)
    (arguments
     (list
      #:go go-1.26
      #:import-path "github.com/spf13/pflag"))
    (home-page "https://github.com/carapace-sh/carapace-pflag")
    (synopsis "Fork of spf13/pflag with non-POSIX flag support")
    (description
     "This is a fork of @code{github.com/spf13/pflag} used by carapace.  It
adds support for non-POSIX flags such as single-dash long flags.")
    (license license:bsd-3)))

(define-public go-github-com-carapace-sh-ssh-config
  ;; Untagged commit pinned by carapace-bin's go.mod replace directive.
  (let ((commit "4f04016b8b4bcc44b97f1dda9324620d35a89e10")
        (revision "0"))
    (package
      (name "go-github-com-carapace-sh-ssh-config")
      (version (git-version "1.4.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/carapace-sh/ssh_config")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0342zwl1cvizwi69hijrj5jgpkwppzhxg6gkxq1inh55154xlzbd"))))
      (build-system go-build-system)
      (arguments
       (list
        #:go go-1.26
        #:import-path "github.com/kevinburke/ssh_config"))
      (home-page "https://github.com/carapace-sh/ssh_config")
      (synopsis "Fork of kevinburke/ssh_config used by carapace")
      (description
       "This package parses OpenSSH @file{ssh_config} files.  It is the
carapace fork of @code{github.com/kevinburke/ssh_config}.")
      (license license:expat))))

;;; Guix's cobra propagates the real spf13/pflag.  Putting both it and the
;;; fork above into one GOPATH would collide, so build a cobra variant whose
;;; pflag input is the fork.  `replace` in modify-inputs matches by input
;;; label, which for (list pkg ...) inputs is the package name.
(define go-github-com-spf13-cobra-for-carapace
  (package
    (inherit go-github-com-spf13-cobra)
    (name "go-github-com-spf13-cobra-for-carapace")
    (propagated-inputs
     (modify-inputs (package-propagated-inputs go-github-com-spf13-cobra)
       (replace "go-github-com-spf13-pflag"
         go-github-com-carapace-sh-carapace-pflag)))))


;;; -----------------------------------------------------------------------
;;; Ordinary missing libraries.
;;; -----------------------------------------------------------------------

(define-public go-github-com-micromdm-plist
  (package
    (name "go-github-com-micromdm-plist")
    (version "0.3.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/micromdm/plist")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1cigdhb0977f3qfqnjp7svg6yskpd77847d84mgfl9gwngw9m4vb"))))
    (build-system go-build-system)
    (arguments
     (list
      #:go go-1.26
      #:import-path "github.com/micromdm/plist"))
    (home-page "https://github.com/micromdm/plist")
    (synopsis "Apple property list encoder and decoder for Go")
    (description
     "This package provides encoding and decoding of Apple XML and binary
property lists (plists), with an API similar to @code{encoding/json}.")
    (license license:expat)))

(define-public go-github-com-carapace-sh-carapace-shlex-v2
  (package
    (name "go-github-com-carapace-sh-carapace-shlex-v2")
    (version "2.0.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/carapace-sh/carapace-shlex")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0jday1pss1gb728magnn5s70d3amivvm6v4z4sg8df07v5zpa46q"))))
    (build-system go-build-system)
    (arguments
     (list
      #:go go-1.26
      ;; Major-version module: the /v2 suffix is part of the import path
      ;; even though the code sits at the repo root.
      #:import-path "github.com/carapace-sh/carapace-shlex/v2"
      ;; cmd/carapace-shlex is a demo tool that imports carapace itself
      ;; (which depends on this package) — test the library only.
      #:test-subdirs #~'("")))
    (home-page "https://github.com/carapace-sh/carapace-shlex")
    (synopsis "Shell-style word splitting for carapace")
    (description
     "This package splits command lines into words like a POSIX shell,
keeping the extra position information carapace needs for completion.")
    (license license:asl2.0)))

(define-public go-github-com-carapace-sh-carapace
  (package
    (name "go-github-com-carapace-sh-carapace")
    (version "1.17.0-alpha")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/carapace-sh/carapace")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1hf1rbpg085fjdz5wn0d487a8j75rlyczpwx5zzxl2iqqg3pc8qv"))))
    (build-system go-build-system)
    (arguments
     (list
      #:go go-1.26
      #:import-path "github.com/carapace-sh/carapace"
      ;; Test only the root package; subdirectories (example/, docs/) pull in
      ;; extra modules this package does not depend on.
      #:test-subdirs #~'("")
      #:phases
      #~(modify-phases %standard-phases
          ;; TestCache needs a writable os.UserCacheDir(); the build
          ;; container's HOME is the unwritable /homeless-shelter.
          (add-before 'check 'set-home
            (lambda _
              (setenv "HOME" "/tmp"))))))
    (propagated-inputs
     (list go-github-com-carapace-sh-carapace-shlex-v2
           go-github-com-spf13-cobra-for-carapace
           go-github-com-carapace-sh-carapace-pflag
           go-go-yaml-in-yaml-v3))
    (home-page "https://carapace.sh")
    (synopsis "Command argument completion library for cobra")
    (description
     "Carapace is a command argument completion generator for
@code{spf13/cobra} that supports many shells, including Bash, Elvish, Fish,
Nushell, Oil, PowerShell, Xonsh and Zsh.")
    ;; LICENSE.appendix only notes features reserved for a commercial
    ;; product; the license itself is plain Apache 2.0.
    (license license:asl2.0)))

(define-public go-github-com-carapace-sh-carapace-bridge
  (package
    (name "go-github-com-carapace-sh-carapace-bridge")
    (version "1.8.0-alpha")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/carapace-sh/carapace-bridge")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1qn77xi2crp8r8rprz0lqk0577qqi95pgmwmq8jdbhri0hx5m4fg"))))
    (build-system go-build-system)
    (arguments
     (list
      #:go go-1.26
      #:import-path "github.com/carapace-sh/carapace-bridge"
      #:skip-build? #t
      #:tests? #f))
    (propagated-inputs
     (list go-github-com-carapace-sh-carapace
           go-github-com-carapace-sh-carapace-shlex-v2
           go-github-com-spf13-cobra-for-carapace))
    (home-page "https://github.com/carapace-sh/carapace-bridge")
    (synopsis "Bridge other completion engines into carapace")
    (description
     "This package lets carapace reuse completions from other engines such
as Bash, Fish, Zsh, argcomplete and urfave/cli.")
    (license license:expat)))

(define-public go-github-com-carapace-sh-carapace-spec
  (package
    (name "go-github-com-carapace-sh-carapace-spec")
    (version "1.10.0-alpha")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/carapace-sh/carapace-spec")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0nkwbl9i8xln6n5wx6x9q0qjbcr7qasgiqc7vhhgw6rmirwabfxk"))))
    (build-system go-build-system)
    (arguments
     (list
      #:go go-1.26
      #:import-path "github.com/carapace-sh/carapace-spec"
      #:test-subdirs #~'("")
      ;; schema.json and example/*.yaml are pulled in with //go:embed.
      ;; This package's OWN files are real copies, so no #:embed-files is
      ;; needed here — only packages that embed files from an input do.
      #:phases
      #~(modify-phases %standard-phases
          ;; The test spec's shebang script runs /usr/bin/env, which does
          ;; not exist in the build container.  (which "env") finds
          ;; coreutils' env in the store.  Only the test fixture is patched.
          (add-before 'check 'patch-test-shebang
            (lambda* (#:key import-path #:allow-other-keys)
              (substitute* (string-append "src/" import-path
                                          "/example/run.yaml")
                (("/usr/bin/env") (which "env"))))))))
    (propagated-inputs
     (list go-github-com-carapace-sh-carapace
           go-github-com-carapace-sh-carapace-shlex-v2
           go-github-com-spf13-cobra-for-carapace
           go-github-com-carapace-sh-carapace-pflag
           go-go-yaml-in-yaml-v3))
    (home-page "https://github.com/carapace-sh/carapace-spec")
    (synopsis "Define carapace completions in YAML")
    (description
     "This package defines command-line completions in YAML spec files
that carapace turns into completions for every shell it supports.")
    (license license:expat)))

(define-public go-github-com-carapace-sh-carapace-selfupdate
  (package
    (name "go-github-com-carapace-sh-carapace-selfupdate")
    (version "0.1.0-alpha")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/carapace-sh/carapace-selfupdate")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0845xh0mg9jd9mfhm0iyrdksr21v6pwy1fw46n6rmpwiz6paql0h"))))
    (build-system go-build-system)
    (arguments
     (list
      #:go go-1.26
      #:import-path "github.com/carapace-sh/carapace-selfupdate"
      #:tests? #f))                     ;no tests
    (propagated-inputs
     (list go-github-com-carapace-sh-carapace
           go-github-com-spf13-cobra-for-carapace))
    (home-page "https://github.com/carapace-sh/carapace-selfupdate")
    (synopsis "Self-update command for carapace tools")
    (description
     "This package implements the @code{--selfupdate} command used by
carapace binaries.  On Guix the store copy is read-only, so updating goes
through Guix instead.")
    (license license:expat)))

;;; Three small completer libraries with the same shape: no root Go files,
;;; only pkg/ and cmd/ trees.
(define (carapace-completer-library repo version hash inputs synopsis)
  (package
    (name (string-append "go-github-com-carapace-sh-" repo))
    (version version)
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url (string-append "https://github.com/carapace-sh/" repo))
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256 (base32 hash))))
    (build-system go-build-system)
    (arguments
     (list
      #:go go-1.26
      #:import-path (string-append "github.com/carapace-sh/" repo)
      #:skip-build? #t
      #:tests? #f))
    (propagated-inputs inputs)
    (home-page (string-append "https://github.com/carapace-sh/" repo))
    (synopsis synopsis)
    (description
     "This package provides carapace completion actions that carapace-bin
links in as a library.")
    (license license:expat)))

(define-public go-github-com-carapace-sh-carapace-jjlex
  (carapace-completer-library
   "carapace-jjlex" "0.1.17"
   "1dpi2ckk51a263kynz61y1sc566pd73h86cqq7p57znn4i4przmc"
   (list go-github-com-carapace-sh-carapace
         go-github-com-carapace-sh-carapace-bridge
         go-github-com-pelletier-go-toml-v2)
   "Carapace completions for Jujutsu (jj)"))

(define-public go-github-com-carapace-sh-carapace-jq
  (carapace-completer-library
   "carapace-jq" "0.0.4"
   "1chrfgf1xc95p7s9n8wjy1cfr04fmw9n544ngvd010f3lfcksv2d"
   (list go-github-com-carapace-sh-carapace)
   "Carapace completions for jq"))

(define-public go-github-com-carapace-sh-carapace-pnpm
  (carapace-completer-library
   "carapace-pnpm" "0.0.2"
   "1andzl6hvqmqbjrm2yz83gy7c6ig9fbib5k4mhk2rp494rxh1n14"
   (list go-github-com-carapace-sh-carapace
         go-github-com-carapace-sh-carapace-bridge
         go-gopkg-in-yaml-v3)
   "Carapace completions for pnpm"))


;;; -----------------------------------------------------------------------
;;; Main package: carapace-bin
;;;
;;; Notes:
;;; - The completer registry (cmd/carapace/cmd/completers/*.go) and two
;;;   *_generated.go files are gitignored; upstream makes them with
;;;   `go generate` before building.  The generator is part of this repo and
;;;   needs only the inputs below, so it runs offline in a pre-build phase.
;;;   Only ./cmd/carapace is generated: ./cmd/... would also cross-compile
;;;   the Windows shim .exe files, which Linux builds never embed.
;;; - `-tags release` matches upstream's goreleaser build (selects the
;;;   completers_release_linux.go list).  CGO is off, also as upstream.
;;; - #:embed-files: carapace-bridge's bash.sh/zsh.sh/capture.zsh and
;;;   carapace-spec's schema.json arrive in GOPATH as symlinks into the
;;;   store, and //go:embed refuses symlinks.  Listing them makes the
;;;   fix-embed-files phase swap the symlinks for real copies.
;;; - The second -ldflags overrides the build system's default "-s -w", so
;;;   it repeats them and adds the version string.
;;; -----------------------------------------------------------------------

(define-public carapace-bin
  (package
    (name "carapace-bin")
    (version "1.8.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/carapace-sh/carapace-bin")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0k8wpwfg9lzmmjwkg7ylwb4w7bskraphr127iv37l9bwnxlqzydk"))))
    (build-system go-build-system)
    (arguments
     (list
      #:go go-1.26
      #:install-source? #f
      #:import-path "github.com/carapace-sh/carapace-bin/cmd/carapace"
      #:unpack-path "github.com/carapace-sh/carapace-bin"
      #:build-flags
      #~(list "-tags=release"
              (string-append "-ldflags=-s -w -X main.version=" #$version))
      #:embed-files #~(list "bash\\.sh" "zsh\\.sh" "capture\\.zsh"
                            "schema\\.json")
      ;; Upstream's test suite exercises each completer against the real
      ;; tools it completes for; not useful inside the build container.
      #:tests? #f
      #:phases
      #~(modify-phases %standard-phases
          (add-before 'build 'disable-cgo
            (lambda _
              (setenv "CGO_ENABLED" "0")))
          ;; The generator reads its module path with `go mod edit -json`,
          ;; which refuses to run under the build system's GO111MODULE=off.
          ;; `go mod edit` only parses go.mod (no network), so re-enable
          ;; modules for that one subprocess via coreutils `env`.
          (add-before 'build 'patch-generator
            (lambda* (#:key unpack-path #:allow-other-keys)
              (substitute* (string-append
                            "src/" unpack-path
                            "/cmd/carapace-generate/pkg/completer/completers.go")
                (("exec\\.Command\\(\"go\", \"mod\", \"edit\", \"-json\"\\)")
                 "exec.Command(\"env\", \"GO111MODULE=on\", \"GOTOOLCHAIN=local\",
\"go\", \"mod\", \"edit\", \"-json\")"))))
          (add-after 'patch-generator 'go-generate
            (lambda* (#:key import-path #:allow-other-keys)
              (with-directory-excursion (string-append "src/" import-path)
                (invoke "go" "generate" "./")
                ;; The generator prints errors but still exits 0, so check
                ;; its output exists rather than trusting the exit code.
                (unless (file-exists?
                         "cmd/completers/completers_release_linux.go")
                  (error "go generate did not produce the completer list")))))
          ;; Nushell sources every file in <profile>/share/nushell/vendor/
          ;; autoload at startup, so shipping the init script here enables
          ;; carapace in nu without touching the user's config.nu.  The
          ;; script embeds the user's config dir at generation time, so
          ;; generate it with a placeholder HOME and turn that back into a
          ;; runtime $env.HOME lookup.
          (add-after 'install 'install-nushell-autoload
            (lambda _
              (let ((dir (string-append #$output
                                        "/share/nushell/vendor/autoload"))
                    (shim-dir "\"/carapace-home/.config/carapace/bin\""))
                (mkdir-p dir)
                (setenv "HOME" "/carapace-home")
                (unsetenv "XDG_CONFIG_HOME")
                (with-directory-excursion dir
                  (invoke "sh" "-c"
                          (string-append #$output "/bin/carapace"
                                         " _carapace nushell > carapace.nu"))
                  (substitute* "carapace.nu"
                    ((shim-dir)
                     "($env.HOME | path join \".config/carapace/bin\")"))
                  ;; Fail if upstream changed the script and a build-time
                  ;; path survived the substitution.
                  ;; (system* returns grep's exit status; 0 = match found.)
                  (when (zero? (system* "grep" "-q" "/carapace-home"
                                        "carapace.nu"))
                    (error "carapace.nu still contains the placeholder HOME")))))))))
    (inputs
     (list go-github-com-carapace-sh-carapace
           go-github-com-carapace-sh-carapace-bridge
           go-github-com-carapace-sh-carapace-jjlex
           go-github-com-carapace-sh-carapace-jq
           go-github-com-carapace-sh-carapace-pnpm
           go-github-com-carapace-sh-carapace-selfupdate
           go-github-com-carapace-sh-carapace-shlex-v2
           go-github-com-carapace-sh-carapace-spec
           go-github-com-carapace-sh-carapace-pflag
           go-github-com-carapace-sh-ssh-config
           go-github-com-spf13-cobra-for-carapace
           go-github-com-micromdm-plist
           go-github-com-pelletier-go-toml
           go-github-com-pelletier-go-toml-v2
           go-go-yaml-in-yaml-v3
           go-golang-org-x-mod
           go-gopkg-in-ini-v1
           go-gopkg-in-yaml-v3))
    (home-page "https://carapace.sh")
    (synopsis "Multi-shell command-line completion engine")
    (description
     "Carapace-bin provides argument completion for over a thousand
command-line tools across many shells, including Bash, Elvish, Fish,
Nushell, Oil, PowerShell, Tcsh, Xonsh and Zsh.  It can also bridge
completions from other engines and load user-defined YAML specs.")
    (license license:expat)))
