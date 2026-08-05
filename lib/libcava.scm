(define-module (lib libcava)
  #:use-module (gnu packages audio)
  #:use-module (gnu packages pkg-config)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system meson)
  #:use-module (guix gexp))

(define-public libcava
  (package
    (inherit cava)
    (name "libcava")
    (version "0.10.6")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/LukashonakV/cava")
             (commit version)))
       (file-name (git-file-name "libcava" version))
       (sha256
        (base32 "17p7lxmk3v4x2gagd3skmb43llcqkg3qrb0f7jhjlcm91kbxwxpb"))))
    (build-system meson-build-system)
    (arguments
     (list
      #:tests? #f
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'install 'install-pc-file
            (lambda* (#:key outputs #:allow-other-keys)
              (let* ((out (assoc-ref outputs "out"))
                     (pc-dir (string-append out "/lib/pkgconfig")))
                (mkdir-p pc-dir)
                (call-with-output-file (string-append pc-dir "/cava.pc")
                  (lambda (port)
                    (format port "prefix=~a
exec_prefix=${prefix}
libdir=${prefix}/lib
includedir=${prefix}/include

Name: cava
Description: Console-based Audio Visualizer for Alsa
Version: ~a
Libs: -L${libdir} -lcava
Cflags: -I${includedir}
" out "0.10.6")))))))))
    (synopsis "cava packaged as a shared library")
    (description
     "libcava is a fork of cava that builds it as a shared library
(@file{libcava.so}) rather than a standalone executable, primarily
for use by Waybar's cava module.")))

libcava
