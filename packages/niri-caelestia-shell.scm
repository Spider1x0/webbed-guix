(define-module (packages niri-caelestia-shell)
  #:use-module (lib quickshell-git)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system cmake)
  #:use-module (guix gexp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages audio)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages image)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages wm)
  #:use-module (lib libcava))

(define-public niri-caelestia-shell
  (package
    (name "niri-caelestia-shell")
    (version "0.0.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/Spider1x0/niri-caelestia-shell")
             (commit "9db188f6583151d4479ed004fdbaf9dfa73c0b7f")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "06kww6h9ixk0m9syl8gbssdgqkyvfsnamgrd5g41l82swi10yvbm"))))
    (build-system cmake-build-system)
    (arguments
     (list
      #:tests? #f
      #:configure-flags
      #~(list
         (string-append "-DINSTALL_LIBDIR=" #$output "/lib/caelestia")
         (string-append "-DINSTALL_QMLDIR=" #$output "/lib/qt6/qml")
         (string-append "-DINSTALL_QSCONFDIR=" #$output "/share/quickshell/niri-caelestia-shell")
         (string-append "-DVERSION=" #$version)
         "-DGIT_REVISION=guix-build"
         "-DDISTRIBUTOR=Guix"
         "-DENABLE_MODULES=extras;plugin;shell")
      #:phases
      #~(modify-phases %standard-phases
          (add-before 'configure 'fix-git-vars
            (lambda _
              (invoke "python3" "-c"
                (string-append
                 "import re, pathlib\n"
                 "f = pathlib.Path('CMakeLists.txt')\n"
                 "t = f.read_text()\n"
                 "t = re.sub(r'if\\(NOT DEFINED VERSION\\).*?endif\\(\\)\\s*endif\\(\\)', '', t, flags=re.DOTALL)\n"
                 "t = re.sub(r'if\\(NOT DEFINED GIT_REVISION\\).*?endif\\(\\)\\s*endif\\(\\)', '', t, flags=re.DOTALL)\n"
                 "f.write_text(t)\n"))))
(add-after 'install 'create-launcher
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (let* ((out (assoc-ref outputs "out"))
                     (qs (search-input-file inputs "bin/qs"))
                     (bin-dir (string-append out "/bin")))
                (mkdir-p bin-dir)
                (let ((launcher (string-append bin-dir "/niri-caelestia-shell")))
                  (call-with-output-file launcher
                    (lambda (port)
                      (format port "#!/bin/sh\nexec ~a -p ~a -n \"$@\"\n"
                              qs
                              (string-append out "/share/quickshell/niri-caelestia-shell"))))
                  (chmod launcher #o755))
                (wrap-program (string-append bin-dir "/niri-caelestia-shell")

                              `("QML2_IMPORT_PATH" = (,(string-append out "/lib/qt6/qml")))
                              `("QT_QPA_PLATFORM_PLUGIN_PATH" = (,(string-append (assoc-ref inputs "qtwayland") "/lib/qt6/plugins/platforms")))
                  `("PATH" prefix
                    ,(map (lambda (pkg)
                            (string-append (assoc-ref inputs pkg) "/bin"))
                          '("fish" "bash" "wl-clipboard" "swappy"))))))))))
    (inputs
     (list aubio
           bash
           fish
           fftw
           mpfr
           libcava
           libqalculate
           pipewire
           qtbase
           qtdeclarative
           quickshell-git
           qtmultimedia
           swappy
           qtwayland
           wl-clipboard))
    (native-inputs
     (list pkg-config
           python))
    (home-page "https://github.com/Spider1x0/niri-caelestia-shell")
    (synopsis "Caelestia shell ported to Niri WM")
    (description
     "A Quickshell-based desktop shell forked from Caelestia, adapted to run
with the Niri window manager. Provides a status bar, app launcher, notification
system, media dashboard, and system controls.")
    (license license:gpl3+)))
    niri-caelestia-shell
