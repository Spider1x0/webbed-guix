;;; tuta.scm --- Guix package definition for Tuta (Tutanota) desktop client

(define-module (packages tuta)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system trivial)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages bash)          ; bash-minimal
  #:use-module (gnu packages base)          ; glibc
  #:use-module (gnu packages gcc)           ; gcc:lib
  #:use-module (gnu packages elf)           ; patchelf
  #:use-module (gnu packages compression)   ; squashfs-tools
  #:use-module (gnu packages glib)          ; glib, dbus
  #:use-module (gnu packages gtk)           ; gtk+, cairo, pango, gdk-pixbuf, at-spi2-core
  #:use-module (gnu packages gnome)         ; libsecret, libnotify
  #:use-module (gnu packages xorg)          ; libx11, libxcb, libxcomposite, libxdamage, libxext, libxfixes, libxrandr, libxshmfence
  #:use-module (gnu packages xdisorg)       ; libxkbcommon, libdrm
  #:use-module (gnu packages gl)            ; mesa
  #:use-module (gnu packages cups)          ; cups
  #:use-module (gnu packages nss)           ; nss, nspr
  #:use-module (gnu packages xml)           ; expat
  #:use-module (gnu packages linux)         ; alsa-lib
  #:use-module (gnu packages image)         ; libpng
  #:use-module (gnu packages fontutils))    ; fontconfig, freetype

(define-public tuta
  (package
    (name "tuta")
    (version "355.260720.0")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://github.com/tutao/tutanota/releases/download/"
             "tutanota-desktop-release-" version
             "/tutanota-desktop-linux.AppImage"))
       (file-name (string-append "tutanota-desktop-" version ".AppImage"))
       (sha256
        (base32
         "12igwn6q52fhy2jj41vi5fz1vj6f7w744cfff8yj9rrjvf3svlmi"))))
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils) (srfi srfi-1) (ice-9 rdelim))
       #:builder
       (begin
         (use-modules (guix build utils) (srfi srfi-1) (ice-9 rdelim))

         ;; Read N bytes from PORT as a little-endian unsigned integer.
         (define (read-le-uint port n)
           (let loop ((i 0) (acc 0))
             (if (= i n)
                 acc
                 (let ((b (char->integer (read-char port))))
                   (loop (+ i 1) (+ acc (ash b (* i 8))))))))

         ;; Seek PORT to OFFSET and read N bytes as little-endian uint.
         (define (read-le-uint-at port offset n)
           (seek port offset SEEK_SET)
           (read-le-uint port n))

         ;; Compute SquashFS offset from 64-bit ELF header fields.
         ;; For a Type-2 AppImage the squashfs immediately follows the ELF:
         ;;   offset = e_shoff + e_shnum * e_shentsize
         ;; ELF64 field offsets: e_shoff@40(8B), e_shentsize@58(2B), e_shnum@60(2B).
         ;; Use "rb" binary mode so non-ASCII bytes are read as raw bytes.
         (define (appimage-squashfs-offset path)
           (let* ((port      (open-file path "rb"))
                  (e-shoff   (read-le-uint-at port 40 8))
                  (e-shentsz (read-le-uint-at port 58 2))
                  (e-shnum   (read-le-uint-at port 60 2)))
             (close-port port)
             (+ e-shoff (* e-shnum e-shentsz))))

         (let* ((out        (assoc-ref %outputs "out"))
                (share      (string-append out "/share/tuta"))
                (bin        (string-append out "/bin"))
                (appimage   (assoc-ref %build-inputs "source"))
                (unsquashfs (string-append
                             (assoc-ref %build-inputs "squashfs-tools")
                             "/bin/unsquashfs"))
                (patchelf   (string-append
                             (assoc-ref %build-inputs "patchelf")
                             "/bin/patchelf"))
                (bash       (string-append
                             (assoc-ref %build-inputs "bash-minimal")
                             "/bin/bash"))
                (loader     (string-append
                             (assoc-ref %build-inputs "glibc")
                             "/lib/ld-linux-x86-64.so.2"))
                (skip-inputs '("source" "squashfs-tools" "patchelf" "bash-minimal"))
                (rpath
                 (string-join
                  (filter-map
                   (lambda (entry)
                     (let* ((iname (car entry))
                            (ipath (cdr entry))
                            (lib   (string-append ipath "/lib")))
                       (and (not (member iname skip-inputs))
                            (file-exists? lib)
                            lib)))
                   %build-inputs)
                  ":")))

           ;; Create output directories
           (mkdir-p share)
           (mkdir-p bin)

           ;; Copy AppImage to a writable location (store inputs are read-only)
           (copy-file appimage "tuta.AppImage")
           (chmod "tuta.AppImage" #o755)

           ;; Compute the SquashFS offset from the ELF header.
           ;; AppImage type-2: squashfs immediately follows the ELF section table.
           (let ((offset (appimage-squashfs-offset "tuta.AppImage")))
             (format #t "SquashFS offset: ~a bytes~%" offset)
             (invoke unsquashfs "-o" (number->string offset)
                     "-d" "squashfs-root" "tuta.AppImage"))

           ;; Install extracted tree into share/tuta
           (copy-recursively "squashfs-root" share)

           ;; Find the main Electron binary.
           ;; It is the executable ELF at the root of the extracted tree,
           ;; typically named "tutanota-desktop".
           (let* ((top-level-execs
                   (filter
                    (lambda (f)
                      (let ((st (stat f #f)))
                        (and st
                             (eq? (stat:type st) 'regular)
                             (not (zero? (logand (stat:perms st) #o111)))
                             (string=? (dirname f) share)
                             ;; Exclude shared libraries
                             (not (string-suffix? ".so" f))
                             (not (string-contains f ".so.")))))
                    (find-files share #:directories? #f)))
                  (elf-binary
                   (or (find (lambda (f)
                               (string=? (basename f) "tutanota-desktop"))
                             top-level-execs)
                       (and (not (null? top-level-execs))
                            (car top-level-execs)))))

             (unless elf-binary
               (error "Could not locate main Electron binary in extracted AppImage"))

             (format #t "Patching ELF: ~a~%" elf-binary)

             ;; Patch the bundled Electron runtime to use Guix's loader and libs
             (invoke patchelf "--set-interpreter" loader elf-binary)
             (invoke patchelf "--set-rpath" rpath elf-binary)

             ;; Write launcher script
             (let ((launcher (string-append bin "/tuta")))
               (call-with-output-file launcher
                 (lambda (p)
                   (format p "#!~a~%export LD_LIBRARY_PATH=\"~a${LD_LIBRARY_PATH:+:}$LD_LIBRARY_PATH\"~%exec \"~a\" \"$@\"~%"
                           bash rpath elf-binary)))
               (chmod launcher #o755))

             ;; Install .desktop file
             (let ((apps-dir (string-append out "/share/applications")))
               (mkdir-p apps-dir)
               (let ((desktops (find-files share "\\.desktop$")))
                 (unless (null? desktops)
                   (install-file (car desktops) apps-dir))))

             ;; Install icons
             (let ((icons-dir (string-append out "/share/icons/hicolor/256x256/apps")))
               (mkdir-p icons-dir)
               (for-each
                (lambda (f)
                  (install-file f icons-dir))
                (find-files share "\\.png$"))))))))
    (native-inputs
     (list squashfs-tools))
    (inputs
     (list bash-minimal
           glibc
           `(,gcc "lib")
           patchelf
           nss
           nspr
           at-spi2-core
           cairo
           cups
           dbus
           expat
           gdk-pixbuf
           glib
           gtk+
           pango
           mesa
           libx11
           libxcb
           libxcomposite
           libxdamage
           libxext
           libxfixes
           libxrandr
           libxkbcommon
           libxshmfence
           alsa-lib
           libdrm
           libsecret
           libnotify
           libpng
           fontconfig
           freetype))
    (home-page "https://tuta.com")
    (synopsis "Tuta (Tutanota) end-to-end encrypted email desktop client")
    (description
     "Prebuilt desktop client for the Tuta encrypted email service, repackaged
from the upstream AppImage: the bundled Electron runtime is patched to use
Guix's shared libraries.")
    (license license:gpl3)))
