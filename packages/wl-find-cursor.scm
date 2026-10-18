;;; wl-find-cursor: highlight and print the global mouse position on
;;; wlroots compositors (sway, Scroll, river...) via layer-shell and
;;; virtual-pointer.  Also the wlroots cursor-position backend that
;;; wayland-automation shells out to.
;;;
;;; Usage:
;;;   guix build -L ~/webbed-guide wl-find-cursor
(define-module (packages wl-find-cursor)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages freedesktop))   ; wayland, wayland-protocols

(define-public wl-find-cursor
  ;; Upstream has no releases or tags.
  (let ((commit "ce1a125702b466dc537c5490f7888b4a68dee883")
        (revision "0"))
    (package
      (name "wl-find-cursor")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/cjacker/wl-find-cursor")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "09cfdz9pcvqqyaggxijggq9wlniw2wgh58ll9dl5j5wn8dcdwji1"))))
      (build-system gnu-build-system)
      (arguments
       (list
        #:tests? #f                     ;no test suite
        #:phases
        #~(modify-phases %standard-phases
            (delete 'configure)         ;plain Makefile
            ;; The Makefile reads protocol XML from the FHS path
            ;; /usr/share/wayland-protocols, which doesn't exist on Guix.
            ;; #$(this-package-native-input ...) resolves to the store path
            ;; of that input at build time.
            (add-after 'unpack 'patch-protocol-dir
              (lambda _
                (substitute* "Makefile"
                  (("/usr/share/wayland-protocols")
                   #$(file-append (this-package-native-input
                                   "wayland-protocols")
                                  "/share/wayland-protocols")))))
            ;; `make install` depends on a nonexistent `default` target, so
            ;; install the single binary by hand.
            (replace 'install
              (lambda _
                (install-file "wl-find-cursor"
                              (string-append #$output "/bin")))))))
      (native-inputs
       (list wayland                    ;wayland-scanner
             wayland-protocols))
      (inputs
       (list wayland))                  ;libwayland-client
      (home-page "https://github.com/cjacker/wl-find-cursor")
      (synopsis "Highlight and report the mouse cursor position on Wayland")
      (description
       "wl-find-cursor draws a growing circle at the mouse cursor and prints
its global coordinates.  It uses the layer-shell and virtual-pointer
protocols, so it works on wlroots-based compositors such as Sway but not on
GNOME.  With @option{-p} it only prints the position.")
      (license license:expat))))
