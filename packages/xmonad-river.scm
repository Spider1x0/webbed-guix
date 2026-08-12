(define-module (packages xmonad-river)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system haskell)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages haskell-check)
  #:use-module (gnu packages haskell-xyz)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages wm))

(define-public ghc-store-core
  (package
    (name "ghc-store-core")
    (version "0.4.4.7")
    (source
     (origin
       (method url-fetch)
       (uri (hackage-uri "store-core" version))
       (sha256
        (base32 "1lxwl6zlmmdk62c35dwmx4xpcfvjx61is8ccmnr8i01i9l9i19b4"))))
    (build-system haskell-build-system)
    (properties '((upstream-name . "store-core")))
    (inputs (list ghc-primitive))
    (home-page "https://github.com/fpco/store")
    (synopsis "Fast binary serialization primitives")
    (description
     "Core functionality for the @code{store} binary serialization library,
providing fast serialization via unsafe memory operations.")
    (license license:expat)))

(define-public xmonad-river
  (package
    (inherit xmonad)
    (name "xmonad-river")
    (version "0.18.1.9")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/mgsloan/xmonad")
              (commit "dec3b72d726c766dfeba2a605f51e52073d96538")))
       (file-name (git-file-name "xmonad-river" version))
       (sha256
        (base32 "1vgb3qn02493p3xkfb6xd3gnqmsxkdw7952xv74s4n22a7gd5ggq"))))
    ;; Tests require a live River compositor; disable in the Guix sandbox.
    (arguments (list #:tests? #f))
    (inputs (list ghc-data-default-class
                  ghc-setlocale
                  ghc-network
                  ghc-store-core
                  libxkbcommon))
    (native-inputs (list ghc-quickcheck
                         ghc-quickcheck-classes
                         pkg-config))
    (properties '())
    (home-page "https://github.com/mgsloan/xmonad/tree/xmonad-on-river")
    (synopsis "XMonad tiling window manager for the River Wayland compositor")
    (description
     "A port of the XMonad tiling window manager targeting the River Wayland
compositor.  Implements the same core XMonad API as a strict subset of upstream
XMonad — names absent from the API fail at compile time rather than silently
doing nothing.  No X11 dependencies; communicates with River directly via
Wayland protocols and Unix sockets.")))
