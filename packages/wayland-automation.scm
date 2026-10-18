;;; wayland-automation: Python library for scripted keyboard/mouse input on
;;; Wayland.  Keyboard goes through wtype; mouse movement speaks the
;;; zwlr_virtual_pointer_manager_v1 protocol directly over the Wayland
;;; socket (pure Python); cursor position comes from wl-find-cursor on
;;; wlroots compositors.
;;;
;;; Usage:
;;;   guix build -L ~/webbed-guide python-wayland-automation
(define-module (packages wayland-automation)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix download)
  #:use-module (guix build-system pyproject)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages freedesktop)       ; wtype, wayland-utils
  #:use-module (gnu packages linux)             ; python-evdev
  #:use-module (gnu packages python-build)      ; setuptools, wheel
  #:use-module (packages wl-find-cursor))

(define-public python-wayland-automation
  (package
    (name "python-wayland-automation")
    (version "0.2.8")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "wayland_automation" version))
       (sha256
        (base32 "0vga5kzac94fnfsah7spqr7dpgpk2nzhjzkssh5p5y0p1vlwyhc9"))))
    (build-system pyproject-build-system)
    (arguments
     (list
      #:tests? #f                       ;no test suite in the sdist
      #:phases
      #~(modify-phases %standard-phases
          ;; It shells out to wtype, wayland-info and wl-find-cursor by
          ;; name.  It is mostly used as an imported library, where a
          ;; wrapper script's PATH wouldn't apply, so point the calls at
          ;; the store instead.  hyprctl/xdotool stay PATH lookups: they are
          ;; optional backends for other compositors.
          (add-after 'unpack 'patch-tool-paths
            (lambda* (#:key inputs #:allow-other-keys)
              (let ((wtype (search-input-file inputs "bin/wtype"))
                    (wayland-info (search-input-file inputs
                                                     "bin/wayland-info"))
                    (wl-find-cursor (search-input-file inputs
                                                       "bin/wl-find-cursor")))
                (substitute* (find-files "wayland_automation" "\\.py$")
                  (("\"wtype\"") (string-append "\"" wtype "\""))
                  (("'wtype'") (string-append "'" wtype "'"))
                  (("\"wayland-info\"")
                   (string-append "\"" wayland-info "\""))
                  (("'wayland-info'")
                   (string-append "'" wayland-info "'"))
                  (("shutil\\.which\\(\"wl-find-cursor\"\\)")
                   (string-append "shutil.which(\"" wl-find-cursor "\")")))))))))
    (native-inputs
     (list python-setuptools python-wheel))
    (inputs
     (list wtype wayland-utils wl-find-cursor))
    (propagated-inputs
     (list python-evdev))
    (home-page "https://github.com/OTAKUWeBer/Wayland-automation")
    (synopsis "Keyboard and mouse automation for Wayland")
    (description
     "This Python library automates keyboard and mouse input on Wayland
compositors.  It types and presses keys through @command{wtype}, moves and
clicks the mouse through the wlroots virtual-pointer protocol, and reads the
cursor position from @command{hyprctl}, @command{wl-find-cursor},
@command{xdotool} or evdev, whichever is available.")
    (license license:expat)))
