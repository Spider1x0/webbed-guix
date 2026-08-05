(define-module (lib wayland-protocols-1-47)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (gnu packages freedesktop))

(define-public wayland-protocols-1.47
  (package
    (inherit wayland-protocols)
    (name "wayland-protocols")
    (version "1.47")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://gitlab.freedesktop.org/wayland/wayland-protocols/-/releases/"
             version "/downloads/wayland-protocols-" version ".tar.xz"))
       (sha256
        (base32
         "084flmicygznjjh40x68aahag5j28cgpvxwcdyjbkfn9rfdk9m2z"))))))

wayland-protocols-1.47
