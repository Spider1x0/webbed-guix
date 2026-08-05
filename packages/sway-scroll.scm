(define-module (packages sway-scroll)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system meson)
  #:use-module (guix gexp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages ghostscript)
  #:use-module (gnu packages web)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages lua)
  #:use-module (gnu packages man)
  #:use-module (gnu packages pciutils)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages vulkan)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xorg)
  #:use-module (lib libdrm-2-4-129)
  #:use-module (lib wayland-protocols-1-47))

(define-public sway-scroll
  (package
    (name "sway-scroll")
    (version "1.12.5")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/dawsers/scroll")
             (commit (string-append "v" version))
             (recursive? #t)))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "0xq6mrvn7l6g4f5lflxfdaz2id5g8wscqgh657bga7jr5zk444vy"))))
    (build-system meson-build-system)
    (arguments
     (list
      #:phases
      #~(modify-phases %standard-phases
          (add-before 'configure 'fix-pkgconfig-paths
            (lambda* (#:key inputs #:allow-other-keys)
              (use-modules (srfi srfi-1))
              ;; Collect lib/pkgconfig and share/pkgconfig from all inputs
              (let* ((pkg-dirs
                      (filter-map
                       (lambda (input)
                         (let ((p (string-append (cdr input) "/lib/pkgconfig")))
                           (and (file-exists? p) p)))
                       inputs))
                     (share-dirs
                      (filter-map
                       (lambda (input)
                         (let ((p (string-append (cdr input) "/share/pkgconfig")))
                           (and (file-exists? p) p)))
                       inputs))
                     ;; lua-5.4 ships as lua-5.4.pc, but wlroots looks for lua.pc
                     (lua54-pc (car (find-files "/gnu/store"
                                                "^lua-5\\.4\\.pc$")))
                     (tmp-dir (string-append (getcwd) "/tmp-pkgconfig"))
                     (lua-pc (string-append tmp-dir "/lua.pc")))
                (mkdir-p tmp-dir)
                (copy-file lua54-pc lua-pc)
                (let ((all-dirs (cons tmp-dir (append pkg-dirs share-dirs))))
                  (format #t "PKG_CONFIG_PATH will be:~%~a~%"
                          (string-join all-dirs "\n"))
                  (setenv "PKG_CONFIG_PATH"
                          (string-join all-dirs ":"))))))
          (add-before 'configure 'delete-wrap-files
            (lambda _
              (for-each delete-file
                        (find-files "subprojects/wlroots/subprojects"
                                    "\\.wrap$"))))
          (replace 'configure
            (lambda* (#:key outputs #:allow-other-keys)
              (mkdir "build")
              (invoke "meson" "setup"
                      "--prefix" (assoc-ref outputs "out")
                      "--buildtype=release"
                      "--wrap-mode=default"
                      "-Dsd-bus-provider=basu"
                      "-Dwerror=false"
                      "-Db_ndebug=true"
                      "build")))
          (replace 'build
            (lambda _
              (invoke "ninja" "-C" (string-append (getcwd) "/build") "-j"
                      (number->string (parallel-job-count)))))
          (delete 'check)
          (replace 'install
            (lambda _
              (invoke "ninja" "-C" (string-append (getcwd) "/build") "install"))))))
    (inputs
     (list basu
           cairo
           eudev
           gdk-pixbuf
           glslang
           hwdata
           json-c
           lcms
           libdisplay-info
           libdrm-2.4.129
           libevdev
           libinput-minimal
           libxkbcommon
           libliftoff
           lua-5.4
           mesa
           pango
           pcre2
           pixman
           libseat
           vulkan-loader
           wayland
           libxcb
           xcb-util-errors
           xcb-util-renderutil
           xcb-util-wm
           xorg-server-xwayland))
    (native-inputs
     (list linux-pam
           mesa
           pkg-config
           python
           scdoc
           wayland-protocols-1.47))
    (home-page "https://github.com/dawsers/scroll")
    (synopsis "Sway fork with a PaperWM-style scrolling layout")
    (description
     "Scroll is a fork of the Sway Wayland compositor that replaces its
tiling layouts with a single scrolling layout similar to PaperWM, niri,
or hyprscroller.")
    (license license:expat)))

sway-scroll
