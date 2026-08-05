(define-module (lib fonts)
#:use-module (guix packages)
#:use-module (guix download)
#:use-module (guix build-system font)
#:use-module (guix gexp)
#:use-module (guix build-system trivial)
#:use-module ((guix licenses) #:prefix license:))

(define-public font-bigblue-terminal-nerd
  (package
    (name "font-bigblue-terminal-nerd")
    (version "3.4.0")
    (source
     (origin
       (method url-fetch)
       (uri "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/BigBlueTerminal.zip")
       (sha256 (base32 "0ji90yicla2nxfxd0884wpcbpzdi272knsbg344a3ll033n56ca5"))))
    (build-system font-build-system)
    (home-page "https://github.com/ryanoasis/nerd-fonts")
    (synopsis "BigBlue Terminal patched with Nerd Fonts glyphs")
    (description "BigBlue Terminal is an oldschool fixed-width pixel font based on IBM's EGA/VGA charset, patched with Nerd Fonts icons.")
    (license license:cc-by-sa4.0)))

(define-public font-cascadia-code-nerd
  (package
    (name "font-cascadia-code-nerd")
    (version "3.4.0")
    (source
     (origin
       (method url-fetch)
       (uri "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/CascadiaCode.zip")
       (sha256 (base32 "03ll8p12gbcc9nnv6chzmzqw803j1c374p4fk6dbd9m0a4rrk04d"))))
    (build-system font-build-system)
    (home-page "https://github.com/ryanoasis/nerd-fonts")
    (synopsis "Cascadia Code patched with Nerd Fonts glyphs")
    (description "Cascadia Code is a monospaced font from Microsoft with programming ligatures, patched with Nerd Fonts icons.")
    (license license:silofl1.1)))

(define-public font-material-symbols-outlined
  (package
    (name "font-material-symbols-outlined")
    (version "1.0")
    (source
     (origin
       (method url-fetch/zipbomb)
       (uri "https://pixeldrain.com/api/filesystem/w4cUDdQy")
       (sha256 (base32 "0s1z5xpjbz2cyw6x1m0a5vwyv3bxhm9w9figrk4sa27lxvqa1dka"))))
    (build-system font-build-system)
    (home-page "https://fonts.google.com/icons")
    (synopsis "Material Symbols variable icon fonts by Google")
    (description "Variable icon fonts with outlined, rounded, and sharp styles covering 2500+ glyphs.")
    (license license:asl2.0)))

(define-public font-material-symbols-rounded
  (package
    (name "font-material-symbols-rounded")
    (version "1.0")
    (source
     (origin
       (method url-fetch/zipbomb) ;zipbomb to treat the url as a zip not a file
       (uri "https://pixeldrain.com/api/filesystem/xtECbmhC")
       (sha256 (base32 "07d77fma7179wi637vzppciah6ygmfkql25qjfshn5r3188myfr9"))))
    (build-system font-build-system)
    (home-page "https://fonts.google.com/icons")
    (synopsis "Material Symbols variable icon fonts by Google")
    (description "Variable icon fonts with outlined, rounded, and sharp styles covering 2500+ glyphs.")
    (license license:asl2.0)))



(define-public font-material-symbols-sharp
  (package
    (name "font-material-symbols-sharp")
    (version "1.0")
    (source
     (origin
       (method url-fetch/zipbomb)
       (uri "https://pixeldrain.com/api/filesystem/jpKVTEqr")
       (sha256 (base32 "0nwwry76r6rw75vdbpc1mwn7b8cx896f9bdlksljyn1y562sb6xw"))))
    (build-system font-build-system)
    (home-page "https://fonts.google.com/icons")
    (synopsis "Material Symbols variable icon fonts by Google")
    (description "Variable icon fonts with outlined, rounded, and sharp styles covering 2500+ glyphs.")
    (license license:asl2.0)))


(define-public font-material-symbols
  (package
    (name "font-material-symbols")
    (version "1.0")
    (source #f)
    (build-system trivial-build-system)
    (inputs (list font-material-symbols-outlined
                  font-material-symbols-rounded
                  font-material-symbols-sharp))
    (arguments
     `(#:modules ((guix build union))
       #:builder
       (begin
         (use-modules (guix build union))
         (union-build (assoc-ref %outputs "out")
                      (map cdr %build-inputs)))))
    (home-page "https://fonts.google.com/icons")
    (synopsis "Material Symbols variable icon fonts by Google")
    (description "Variable icon fonts with outlined, rounded, and sharp styles covering 2500+ glyphs.")
    (license license:asl2.0)))
