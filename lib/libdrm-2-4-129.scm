(define-module (lib libdrm-2-4-129)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (gnu packages xdisorg))

(define-public libdrm-2.4.129
  (package
    (inherit libdrm)
    (name "libdrm")
    (version "2.4.129")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://dri.freedesktop.org/libdrm/libdrm-"
                           version ".tar.xz"))
       (sha256
        (base32
         "1p3pvxfvw7w63fmfr8fajymv1vv494bnd80bllk7wscdjwzihy2r"))))))
libdrm-2.4.129
