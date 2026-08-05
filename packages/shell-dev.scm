(define-module (packages shell-dev)
  #:use-module (guix packages)
  #:use-module (lib quickshell-git)
  #:use-module (guix download)
  #:use-module (guix build-system cmake)
  #:use-module (guix git-download)
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

(define-public shell-dev
  (package
    (name "shell-dev")
    (version "0.0.1")
    (source
     (origin
      (method git-fetch)
      (uri (git-reference
            (url "https://github.com/Spider1x0/shell")
            (commit "8b15f3d06958af2a12561f8716a1f2d1cb75db3e")  ; just the commit hash
            (recursive? #t)))
      (file-name (git-file-name name version))
      (sha256 (base32 "1g9x4zy3f4bg80zhq45b5as3mj9mvd8r1w5s3vmfz78f7hwmlgwq"))))
    (build-system cmake-build-system)
    (arguments
     (list
      #:tests? #f
      #:configure-flags
      #~(list
         (string-append "-DINSTALL_LIBDIR=" #$output "/lib/caelestia")
         (string-append "-DINSTALL_QMLDIR=" #$output "/lib/qt6/qml")
         (string-append "-DINSTALL_QSCONFDIR=" #$output "/share/caelestia-shell")
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
          (add-after 'install 'create-binary
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (let* ((out (assoc-ref outputs "out"))
                     (qs (search-input-file inputs "bin/qs"))
                     (bin-dir (string-append out "/bin"))
                     (shell-config (string-append out "/share/caelestia-shell")))
                (mkdir-p bin-dir)
                (let ((launcher (string-append bin-dir "/caelestia-shell")))
                  (call-with-output-file launcher
                    (lambda (port)
                          (format port "#!/bin/sh\nexec ~a -c ~a -n \"$@\"\n" qs shell-config)))
                  (chmod launcher #o755))
                (wrap-program (string-append bin-dir "/caelestia-shell")
                  `("CAELESTIA_LIB_DIR" = (,(string-append out "/lib/caelestia")))
                  `("QML2_IMPORT_PATH" = (,(string-append out "/lib/qt6/qml")
                  "/lib/qt6/plugins/platfroms"))
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
           swappy
           wl-clipboard))
    (native-inputs
     (list pkg-config
           python))
    (home-page "https://github.com/caelestia-dots/shell")
    (synopsis "A desktop shell for Hyprland built with Quickshell")
    (description
     "Caelestia-shell is a Quickshell-based desktop shell providing a status
bar, application launcher, notification system, media dashboard, and system
controls with Material Design 3 theming.")
    (license license:gpl3+)))
shell-dev
