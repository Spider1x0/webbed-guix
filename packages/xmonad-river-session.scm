(define-module (packages xmonad-river-session)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix build-system trivial)
  #:use-module ((guix licenses) #:prefix license:))

;;; Login-manager entry for river + xmonad-river.
;;;
;;; sddm lists sessions from /run/current-system/profile/share/wayland-sessions,
;;; so the entry has to come from a package in the system profile.  It runs the
;;; development launcher, which pins river 0.4.8 and the patched xmonad by store
;;; path and restarts xmonad if it crashes.  Kept separate from xmonad-river.scm
;;; so that loading it needs nothing newer than the system's Guix.

(define-public xmonad-river-session
  (package
    (name "xmonad-river-session")
    (version "0.1")
    (source #f)
    (build-system trivial-build-system)
    (arguments
     (list
      #:modules '((guix build utils))
      #:builder
      #~(begin
          (use-modules (guix build utils))
          (let ((dir (string-append #$output "/share/wayland-sessions")))
            (mkdir-p dir)
            (call-with-output-file (string-append dir "/xmonad-river.desktop")
              (lambda (port)
                (display "[Desktop Entry]
Name=xmonad (river)
Comment=xmonad-river with the scrolling layout, on river 0.4.8
Exec=/bin/sh /home/spider/.local/dev/xmonad-river/session.sh
Type=Application
DesktopNames=river;wlroots
" port)))))))
    (home-page "https://github.com/mgsloan/xmonad/tree/xmonad-on-river")
    (synopsis "Login manager session entry for xmonad on river")
    (description
     "Installs a wayland-sessions desktop entry that starts the river
compositor with xmonad-river through the local session launcher.")
    (license license:gpl3+)))
