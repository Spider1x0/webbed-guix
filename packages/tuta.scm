;;; tuta.scm --- Guix package definition for Tuta (Tutanota) desktop client

(define-module (packages tuta)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system trivial)
  #:use-module (guix gexp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages base)        ; glibc
  #:use-module (gnu packages gcc)         ; gcc:lib
  #:use-module (gnu packages elf)         ; patchelf, squashfs-tools
  #:use-module (gnu packages compression) ; squashfs-tools
  #:use-module (gnu packages glib)        ; glib, dbus
  #:use-module (gnu packages gtk)         ; gtk+, cairo, pango, gdk-pixbuf, atk, at-spi2-core
  #:use-module (gnu packages gnome)       ; libsecret, libnotify
  #:use-module (gnu packages xorg)        ; libx11, libxcb, libxcomposite, libxdamage, libxext, libxfixes, libxrandr, libxshmfence
  #:use-module (gnu packages xdisorg)     ; libxkbcommon, libdrm
  #:use-module (gnu packages gl)          ; mesa
  #:use-module (gnu packages cups)        ; cups
  #:use-module (gnu packages nss)         ; nss, nspr
  #:use-module (gnu packages xml)         ; expat
  #:use-module (gnu packages linux)       ; alsa-lib
  #:use-module (gnu packages image)       ; libpng
  #:use-module (gnu packages fontutils))  ; fontconfig, freetype

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
     (list #:builder #~(mkdir #$output)))
    (native-inputs
     (list squashfs-tools))
    (inputs
     (list glibc
           `(,gcc "lib")
           patchelf
           nss
           nspr
           at-spi2-core
           atk
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
