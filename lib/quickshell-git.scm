(define-module (lib quickshell-git)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages polkit)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix gexp))

(define-public quickshell-git
  (package
    (inherit quickshell)
    (name "quickshell-git")
    (version "0.2.1-cddb4f0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://git.outfoxxed.me/outfoxxed/quickshell")
             (commit "cddb4f061bab495f4473ca5f2c571b6c710efef7")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1b9jj6b2b8xa4yvyfnw1hn4mmv8ri9zjyh97xfm16jv2p14fxda1"))))
    (inputs
     (modify-inputs (package-inputs quickshell)
       (append glib polkit)))))

quickshell-git
