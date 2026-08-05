(define-module (packages caelestia-cli)
  #:use-module (lib python-materialyoucolor)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system pyproject)
  #:use-module (guix gexp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages python-build))

(define-public caelestia-cli
  (package
    (name "caelestia-cli")
    (version "1.0.4")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/Spider1x0/cli")
             (commit "66954ec9ef460dd8e95f7a825ed97698bfac1713")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "19ssqnd7pq1v93g4fczxnr1winjy3kvyr18gq25rs3jljg5wbnx3"))))
    (build-system pyproject-build-system)
    (arguments
     (list
      #:tests? #f
      #:python python
      #:phases
      #~(modify-phases %standard-phases
          (delete 'compile-bytecode)
          (add-after 'install 'install-completions
            (lambda* (#:key outputs #:allow-other-keys)
              (let* ((out (assoc-ref outputs "out"))
                     (fish-dir (string-append out "/share/fish/vendor_completions.d")))
                (mkdir-p fish-dir)
                (install-file "completions/caelestia.fish" fish-dir)))))))
    (native-inputs
     (list python
           python-wrapper
           python-hatchling
           python-hatch-vcs))
    (propagated-inputs
     (list python-pillow
           python-materialyoucolor))
    (home-page "https://github.com/caelestia-dots/cli")
    (synopsis "Main control script for the Caelestia dotfiles")
    (description
     "caelestia-cli is the main control script for the Caelestia dotfiles,
providing subcommands for managing the shell, wallpaper, colour scheme,
screenshots, screen recording, and more.")
    (license license:gpl3+)))

caelestia-cli

