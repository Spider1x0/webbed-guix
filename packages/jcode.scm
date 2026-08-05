(define-module (packages jcode)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system copy)
  #:use-module (guix gexp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages elf)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages base))

(define gcc-lib (gexp-input gcc "lib"))

(define-public jcode
  (package
    (name "jcode")
    (version "0.58.0")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://github.com/1jehuang/jcode/releases/download/v"
                    version "/jcode-linux-x86_64.tar.gz"))
              (sha256
               (base32
                "157jj369z2lncwvi5h4k7684v1h3zq1gzhnjq931igdpcbk74xd8"))))
    (build-system copy-build-system)
    (arguments
     (list
      ;; Install the raw binary as jcode.bin; the wrapper script becomes jcode
      #:install-plan
      #~'(("jcode-linux-x86_64.bin" "bin/jcode.bin"))
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'install 'patchelf-and-wrap
            (lambda* (#:key outputs #:allow-other-keys)
              (let* ((out    (assoc-ref outputs "out"))
                     (bin    (string-append out "/bin/jcode.bin"))
                     (wrapper (string-append out "/bin/jcode"))
                     (interp  (string-append #$glibc "/lib/ld-linux-x86-64.so.2"))
                     (rpath   (string-append #$glibc "/lib:" #$gcc-lib "/lib"))
                     (pe      (string-append #$patchelf "/bin/patchelf")))
                ;; Patch the Guix store binary
                (invoke pe "--set-interpreter" interp "--set-rpath" rpath bin)
                ;; Write wrapper: also patches any self-downloaded jcode binary
                ;; under ~/.jcode/builds/versions/*/jcode-linux-x86_64.bin
                ;; if it still has the FHS interpreter (/lib64/...) that Guix lacks.
                (call-with-output-file wrapper
                  (lambda (port)
                    (format port "#!~a/bin/bash~%" #$bash)
                    (format port "interp=~s~%" interp)
                    (format port "rpath=~s~%" rpath)
                    (format port "pe=~s~%" pe)
                    (format port "builds=\"$HOME/.jcode/builds/versions\"~%")
                    (format port "if [ -d \"$builds\" ]; then~%")
                    (format port "  for f in \"$builds\"/*/jcode-linux-x86_64.bin; do~%")
                    (format port "    [ -f \"$f\" ] || continue~%")
                    (format port "    cur=$(\"$pe\" --print-interpreter \"$f\" 2>/dev/null || true)~%")
                    (format port "    case \"$cur\" in~%")
                    (format port "      /lib64/*) \"$pe\" --set-interpreter \"$interp\" --set-rpath \"$rpath\" \"$f\" ;;~%")
                    (format port "    esac~%")
                    (format port "  done~%")
                    (format port "fi~%")
                    (format port "exec ~s \"$@\"~%" bin)))
                (chmod wrapper #o755)))))))
    (native-inputs (list patchelf bash))
    (synopsis "AI coding agent harness")
    (description
     "Terminal-native AI coding agent written in Rust.
An alternative to Claude Code and OpenCode with multi-provider LLM support.")
    (license license:expat)
    (home-page "https://github.com/1jehuang/jcode")))

jcode
