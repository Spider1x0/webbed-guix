;;; herdr.scm --- Guix package definition for herdr
;;; Generated from Cargo.lock and vendor/libghostty-vt/build.zig.zon.nix

(define-module (packages herdr)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix store)
  #:use-module (guix monads)
  #:use-module (guix build-system cargo)
  #:use-module (guix build-system trivial)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module ((gnu packages zig) #:select (zig-0.15)))

;; ---------------------------------------------------------------------------
;; Zig dep origins (raw downloaded archives)
;; ---------------------------------------------------------------------------

(define zig-dep-origin-bindings
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/DearBindings_v0.17_ImGui_v1.92.5-docking.tar.gz")
    (file-name "zig-bindings.tar.gz")
    (sha256 (base32 "18xsf0zisr9q8xqa8g3kh4qkqb9rrikkvqiyhmwzc9h9w00cbzlb"))))

(define zig-dep-origin-breakpad
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/breakpad-b99f444ba5f6b98cac261cbb391d8766b34a5918.tar.gz")
    (file-name "zig-breakpad.tar.gz")
    (sha256 (base32 "1nbadlml3r982bz1wyp17w33hngzkb07f47nrrk0g68s7na9ijkc"))))

(define zig-dep-origin-fontconfig
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/fontconfig-2.14.2.tar.gz")
    (file-name "zig-fontconfig.tar.gz")
    (sha256 (base32 "0mcarq6v9k7k9a8is23vq9as0niv0hbagwdabknaq6472n9dv8iv"))))

(define zig-dep-origin-freetype
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/freetype-1220b81f6ecfb3fd222f76cf9106fecfa6554ab07ec7fdc4124b9bb063ae2adf969d.tar.gz")
    (file-name "zig-freetype.tar.gz")
    (sha256 (base32 "035r5bypzapa1x7za7lpvpkz58fxynz4anqzbk8705hmspsh2wj2"))))

(define zig-dep-origin-gettext
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/gettext-0.24.tar.gz")
    (file-name "zig-gettext.tar.gz")
    (sha256 (base32 "1dqq2ln01mfwr4gblvy0cyvarbqnv09ml5sdhksdlw1xb4ym0669"))))

(define zig-dep-origin-glslang
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/glslang-12201278a1a05c0ce0b6eb6026c65cd3e9247aa041b1c260324bf29cee559dd23ba1.tar.gz")
    (file-name "zig-glslang.tar.gz")
    (sha256 (base32 "1dcpm70fhxk07vk37f5l0hb9gxfv6pjgbqskk8dfbcwwa2xyv8hl"))))

(define zig-dep-origin-gobject
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/gobject-2025-11-08-23-1.tar.zst")
    (file-name "zig-gobject.tar.zst")
    (sha256 (base32 "0j0csvsyvp0193mpkdp25s14kargppmdyslbhi5qw788y0347gfr"))))

(define zig-dep-origin-gtk4-layer-shell
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/gtk4-layer-shell-1.1.0.tar.gz")
    (file-name "zig-gtk4-layer-shell.tar.gz")
    (sha256 (base32 "12396gx723ybgq1xp9i02257hsmzqhb5z9b39xdyypha4s0l4a4q"))))

(define zig-dep-origin-harfbuzz
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/harfbuzz-11.0.0.tar.xz")
    (file-name "zig-harfbuzz.tar.xz")
    (sha256 (base32 "16rb7aazy36pj3xrjy149dd90j9yv7q5jnqx5kz2air1zsx52qzi"))))

(define zig-dep-origin-highway
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/highway-66486a10623fa0d72fe91260f96c892e41aceb06.tar.gz")
    (file-name "zig-highway.tar.gz")
    (sha256 (base32 "04m21b46h6c4x099r9qb720ql9llpzz8yq3k94i8zq7l7s4zim47"))))

(define zig-dep-origin-imgui
  (origin
    (method url-fetch)
    (uri "https://github.com/ocornut/imgui/archive/refs/tags/v1.92.5-docking.tar.gz")
    (file-name "zig-imgui.tar.gz")
    (sha256 (base32 "1jzr65gpx4mqfcdbnf2rm2kd20jmj9whwdb7x1df3wvmih7c45n8"))))

(define zig-dep-origin-iterm2-themes
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/ghostty-themes-release-20260511-160054-2671288.tgz")
    (file-name "zig-iterm2-themes.tgz")
    (sha256 (base32 "0d3yksshk5jbbxdnjm9q4qrz6x9p4z0gqqi0i38v3n3kmi84jqs7"))))

(define zig-dep-origin-jetbrains-mono
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/JetBrainsMono-2.304.tar.gz")
    (file-name "zig-jetbrains-mono.tar.gz")
    (sha256 (base32 "1i2w213919avi0apgbw720wqy0z46a89bwv3b65hkbc2icg6jyn5"))))

(define zig-dep-origin-libpng
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/libpng-1220aa013f0c83da3fb64ea6d327f9173fa008d10e28bc9349eac3463457723b1c66.tar.gz")
    (file-name "zig-libpng.tar.gz")
    (sha256 (base32 "0fm0y7543w2gx5sz3zg9i46x1am51c77a554r0zqwpphdjs9bk7y"))))

(define zig-dep-origin-libxev
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/libxev-34fa50878aec6e5fa8f532867001ab3c36fae23e.tar.gz")
    (file-name "zig-libxev.tar.gz")
    (sha256 (base32 "1mvx91wn7499xfx76fxijq4x66x1g5yk4cpr52hii9g4jrmyl0v0"))))

(define zig-dep-origin-libxml2
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/libxml2-2.11.5.tar.gz")
    (file-name "zig-libxml2.tar.gz")
    (sha256 (base32 "05b2kbccbkb5pkizwx2s170lcqvaj7iqjr5injsl5sry5sg0aa3c"))))

(define zig-dep-origin-nerd-fonts-symbols-only
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/NerdFontsSymbolsOnly-3.4.0.tar.gz")
    (file-name "zig-nerd-fonts-symbols-only.tar.gz")
    (sha256 (base32 "010d7gkv359qg555d89i4hhgb56c8f69kw5jsx4f5gflaswx2r0i"))))

(define zig-dep-origin-oniguruma
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/oniguruma-1220c15e72eadd0d9085a8af134904d9a0f5dfcbed5f606ad60edc60ebeccd9706bb.tar.gz")
    (file-name "zig-oniguruma.tar.gz")
    (sha256 (base32 "187jk4fxdkzc0wrcx4kdy4v6p1snwmv8r97i1d68yi3q5qha26h0"))))

(define zig-dep-origin-pixels
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/pixels-12207ff340169c7d40c570b4b6a97db614fe47e0d83b5801a932dcd44917424c8806.tar.gz")
    (file-name "zig-pixels.tar.gz")
    (sha256 (base32 "06pi3f3lhyxfzczhwrc2b4n0jhhzydbz96qlpw12a24is0b3ps2m"))))

(define zig-dep-origin-plasma-wayland-protocols
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/plasma_wayland_protocols-12207e0851c12acdeee0991e893e0132fc87bb763969a585dc16ecca33e88334c566.tar.gz")
    (file-name "zig-plasma-wayland-protocols.tar.gz")
    (sha256 (base32 "0hgl1p173pxs50z1p6mjjzcqssn44aq0ip166k56p3nd98hvln2w"))))

(define zig-dep-origin-sentry
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/sentry-1220446be831adcca918167647c06c7b825849fa3fba5f22da394667974537a9c77e.tar.gz")
    (file-name "zig-sentry.tar.gz")
    (sha256 (base32 "1pqqqcin8nw398rvn187dfqlab4vikdssiry14qqs6nnr1y4kiia"))))

(define zig-dep-origin-spirv-cross
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/spirv_cross-1220fb3b5586e8be67bc3feb34cbe749cf42a60d628d2953632c2f8141302748c8da.tar.gz")
    (file-name "zig-spirv-cross.tar.gz")
    (sha256 (base32 "1qspcsx56v0mddarb6f05i748wsl2ln3d8863ydsczsyqk7nyaxm"))))

(define zig-dep-origin-uucode-0-1-0
  (origin
    (method url-fetch)
    (uri "https://github.com/jacobsandlund/uucode/archive/5f05f8f83a75caea201f12cc8ea32a2d82ea9732.tar.gz")
    (file-name "zig-uucode-0-1-0.tar.gz")
    (sha256 (base32 "0ap6cvgbj7am1zyvl0h52ja6v4p1rbh0mi31g6jlcrg2hzh0mfa0"))))

(define zig-dep-origin-uucode-0-2-0
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/uucode-0.2.0-ZZjBPqZVVABQepOqZHR7vV_NcaN-wats0IB6o-Exj6m9.tar.gz")
    (file-name "zig-uucode-0-2-0.tar.gz")
    (sha256 (base32 "15az8qzp0rg5qj8ma0dam9j8jbf4wwb7wxsiq3iymmlb9w7yxayh"))))

(define zig-dep-origin-vaxis
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/vaxis-7dbb9fd3122e4ffad262dd7c151d80d863b68558.tar.gz")
    (file-name "zig-vaxis.tar.gz")
    (sha256 (base32 "1xlf12dlzda0z4d3svq0qibvfgqzkrv4igg6qqg58nwwr0mk6wif"))))

(define zig-dep-origin-wayland
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/wayland-9cb3d7aa9dc995ffafdbdef7ab86a949d0fb0e7d.tar.gz")
    (file-name "zig-wayland.tar.gz")
    (sha256 (base32 "03f574n5w0y6glr7lf8xjd71844qh8kxxb1s3zjpfxj3ivb92hga"))))

(define zig-dep-origin-wayland-protocols-1
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/wayland-protocols-258d8f88f2c8c25a830c6316f87d23ce1a0f12d9.tar.gz")
    (file-name "zig-wayland-protocols-1.tar.gz")
    (sha256 (base32 "1y1h0pmql53x6ixbsycgkzxlxsxqs9fkps754c7ycx8vx3fwmvaw"))))

(define zig-dep-origin-wayland-protocols-2
  (origin
    (method url-fetch)
    (uri "https://gitlab.freedesktop.org/wayland/wayland-protocols/-/archive/1.47/wayland-protocols-1.47.tar.gz")
    (file-name "zig-wayland-protocols-2.tar.gz")
    (sha256 (base32 "08rjsdh8w0lpj2pr83rziw0yxh4szfsw9p5fg8jkh47lnm5g2bfx"))))

(define zig-dep-origin-wuffs
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/wuffs-122037b39d577ec2db3fd7b2130e7b69ef6cc1807d68607a7c232c958315d381b5cd.tar.gz")
    (file-name "zig-wuffs.tar.gz")
    (sha256 (base32 "04qwpr8c4xjla4skwb1fpvkjc0c611qhbhz9xp3c9rlnpq5d4k4y"))))

(define zig-dep-origin-z2d
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/z2d-0.10.0-j5P_Hu-6FgBsZNgwphIqh17jDnj8_yPtD8yzjO6PpHRQ.tar.gz")
    (file-name "zig-z2d.tar.gz")
    (sha256 (base32 "1xwpcw2awxf2r1kz27m0j4pzpi5g92gd1i2mzqvhkvnmxyi1vwk9"))))

(define zig-dep-origin-zf
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/zf-3c52637b7e937c5ae61fd679717da3e276765b23.tar.gz")
    (file-name "zig-zf.tar.gz")
    (sha256 (base32 "0s25gjvp7rns1l52jvgbd7aakndlvfs5xh9b4wk9wkphia95s09v"))))

(define zig-dep-origin-zig-js
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/zig_js-04db83c617da1956ac5adc1cb9ba1e434c1cb6fd.tar.gz")
    (file-name "zig-zig-js.tar.gz")
    (sha256 (base32 "18vkzib7xgvk4g1xk18070w3yfg9kjnqc0q9p029blqmc3jih82c"))))

(define zig-dep-origin-zig-objc
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/zig_objc-f356ed02833f0f1b8e84d50bed9e807bf7cdc0ae.tar.gz")
    (file-name "zig-zig-objc.tar.gz")
    (sha256 (base32 "1k4fq05brsm799qpkxbwcq1dgs5jyc4hkcrcfb6nyd95frrsz16x"))))

(define zig-dep-origin-zig-wayland
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/zig_wayland-1b5c038ec10da20ed3a15b0b2a6db1c21383e8ea.tar.gz")
    (file-name "zig-zig-wayland.tar.gz")
    (sha256 (base32 "0khjg5q1z1d4sgnyhfjqzb8c6wizx79p3gz343sjgmfhbrrnn52g"))))

(define zig-dep-origin-zigimg
  (origin
    (method url-fetch)
    (uri "https://github.com/ivanstepanovftw/zigimg/archive/d7b7ab0ba0899643831ef042bd73289510b39906.tar.gz")
    (file-name "zig-zigimg.tar.gz")
    (sha256 (base32 "0ly53dd3pj8hl3kkf3h8x4dw79yb7riwj9qc9da18mdkl9mxf7ic"))))

(define zig-dep-origin-zlib
  (origin
    (method url-fetch)
    (uri "https://deps.files.ghostty.org/zlib-1220fed0c74e1019b3ee29edae2051788b080cd96e90d56836eea857b0b966742efb.tar.gz")
    (file-name "zig-zlib.tar.gz")
    (sha256 (base32 "0p6h2i9ajdp46lckdpibfqy4vz5nh5r22bqq96mp41k0ydiqis0p"))))


;; ---------------------------------------------------------------------------
;; Zig dep unpacked derivations
;; Each runs `zig fetch` on the archive to unpack it into a content-addressed
;; directory matching what `zig build --system` expects.
;; ---------------------------------------------------------------------------

(define zig-dep-unpacked-bindings
  (computed-file "zig-dep-bindings"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-bindings"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-bindings) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-breakpad
  (computed-file "zig-dep-breakpad"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-breakpad"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-breakpad) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-fontconfig
  (computed-file "zig-dep-fontconfig"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-fontconfig"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-fontconfig) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-freetype
  (computed-file "zig-dep-freetype"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-freetype"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-freetype) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-gettext
  (computed-file "zig-dep-gettext"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-gettext"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-gettext) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-glslang
  (computed-file "zig-dep-glslang"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-glslang"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-glslang) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))



(define zig-dep-unpacked-gobject
  (computed-file "zig-dep-gobject"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-gobject"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-gobject) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-gtk4-layer-shell
  (computed-file "zig-dep-gtk4-layer-shell"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-gtk4-layer-shell"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-gtk4-layer-shell) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-harfbuzz
  (computed-file "zig-dep-harfbuzz"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-harfbuzz"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-harfbuzz) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-highway
  (computed-file "zig-dep-highway"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-highway"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-highway) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-imgui
  (computed-file "zig-dep-imgui"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-imgui"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-imgui) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-iterm2-themes
  (computed-file "zig-dep-iterm2-themes"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-iterm2-themes"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-iterm2-themes) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-jetbrains-mono
  (computed-file "zig-dep-jetbrains-mono"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-jetbrains-mono"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-jetbrains-mono) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-libpng
  (computed-file "zig-dep-libpng"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-libpng"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-libpng) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-libxev
  (computed-file "zig-dep-libxev"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-libxev"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-libxev) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-libxml2
  (computed-file "zig-dep-libxml2"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-libxml2"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-libxml2) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-nerd-fonts-symbols-only
  (computed-file "zig-dep-nerd-fonts-symbols-only"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-nerd-fonts-symbols-only"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-nerd-fonts-symbols-only) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-oniguruma
  (computed-file "zig-dep-oniguruma"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-oniguruma"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-oniguruma) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-pixels
  (computed-file "zig-dep-pixels"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-pixels"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-pixels) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-plasma-wayland-protocols
  (computed-file "zig-dep-plasma-wayland-protocols"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-plasma-wayland-protocols"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-plasma-wayland-protocols) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-sentry
  (computed-file "zig-dep-sentry"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-sentry"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-sentry) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-spirv-cross
  (computed-file "zig-dep-spirv-cross"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-spirv-cross"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-spirv-cross) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-uucode-0-1-0
  (computed-file "zig-dep-uucode-0-1-0"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-uucode-0-1-0"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-uucode-0-1-0) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-uucode-0-2-0
  (computed-file "zig-dep-uucode-0-2-0"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-uucode-0-2-0"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-uucode-0-2-0) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-vaxis
  (computed-file "zig-dep-vaxis"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-vaxis"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-vaxis) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-wayland
  (computed-file "zig-dep-wayland"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-wayland"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-wayland) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-wayland-protocols-1
  (computed-file "zig-dep-wayland-protocols-1"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-wayland-protocols-1"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-wayland-protocols-1) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-wayland-protocols-2
  (computed-file "zig-dep-wayland-protocols-2"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-wayland-protocols-2"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-wayland-protocols-2) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-wuffs
  (computed-file "zig-dep-wuffs"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-wuffs"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-wuffs) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-z2d
  (computed-file "zig-dep-z2d"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-z2d"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-z2d) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-zf
  (computed-file "zig-dep-zf"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-zf"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-zf) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-zig-js
  (computed-file "zig-dep-zig-js"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-zig-js"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-zig-js) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-zig-objc
  (computed-file "zig-dep-zig-objc"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-zig-objc"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-zig-objc) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-zig-wayland
  (computed-file "zig-dep-zig-wayland"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-zig-wayland"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-zig-wayland) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-zigimg
  (computed-file "zig-dep-zigimg"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-zigimg"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-zigimg) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))

(define zig-dep-unpacked-zlib
  (computed-file "zig-dep-zlib"
    (with-imported-modules '((guix build utils))
      #~(begin
          (use-modules (guix build utils) (ice-9 popen) (ice-9 rdelim))
          (let* ((cache (string-append (getcwd) "/cache-zlib"))
                 (pipe (open-input-pipe
                        (string-join
                         (list #$(file-append zig-0.15 "/bin/zig")
                               "fetch" "--global-cache-dir" cache
                               #$zig-dep-origin-zlib) " ")))
                 (hash (string-trim-right (read-line pipe))))
            (close-port pipe)
            (copy-recursively (string-append cache "/p/" hash) #$output)
            (chmod #$output #o755))))))


;; ---------------------------------------------------------------------------
;; zig-ghostty-vt-system-dir
;; A single store item: a directory of symlinks named by .zon hash keys,
;; each pointing to the corresponding unpacked Zig package derivation.
;; Passed to herdr via LIBGHOSTTY_VT_ZIG_SYSTEM_DIR.
;; ---------------------------------------------------------------------------

(define zig-ghostty-vt-system-dir
  (computed-file "zig-ghostty-vt-system-dir"
    #~(begin
        (mkdir #$output)
        (symlink #$zig-dep-unpacked-bindings
                 (string-append #$output "/N-V-__8AANT61wB--nJ95Gj_ctmzAtcjloZ__hRqNw5lC1Kr"))
        (symlink #$zig-dep-unpacked-breakpad
                 (string-append #$output "/N-V-__8AALw2uwF_03u4JRkZwRLc3Y9hakkYV7NKRR9-RIZJ"))
        (symlink #$zig-dep-unpacked-fontconfig
                 (string-append #$output "/N-V-__8AAIrfdwARSa-zMmxWwFuwpXf1T3asIN7s5jqi9c1v"))
        (symlink #$zig-dep-unpacked-freetype
                 (string-append #$output "/N-V-__8AAKLKpwC4H27Ps_0iL3bPkQb-z6ZVSrB-x_3EEkub"))
        (symlink #$zig-dep-unpacked-gettext
                 (string-append #$output "/N-V-__8AADcZkgn4cMhTUpIz6mShCKyqqB-NBtf_S2bHaTC-"))
        (symlink #$zig-dep-unpacked-glslang
                 (string-append #$output "/N-V-__8AABzkUgISeKGgXAzgtutgJsZc0-kkeqBBscJgMkvy"))
        (symlink #$zig-dep-unpacked-gobject
                 (string-append #$output "/gobject-0.3.0-Skun7ANLnwDvEfIpVmohcppXgOvg_I6YOJFmPIsKfXk-"))
        (symlink #$zig-dep-unpacked-gtk4-layer-shell
                 (string-append #$output "/N-V-__8AALiNBAA-_0gprYr92CjrMj1I5bqNu0TSJOnjFNSr"))
        (symlink #$zig-dep-unpacked-harfbuzz
                 (string-append #$output "/N-V-__8AAG02ugUcWec-Ndp-i7JTsJ0dgF8nnJRUInkGLG7G"))
        (symlink #$zig-dep-unpacked-highway
                 (string-append #$output "/N-V-__8AAGmZhABbsPJLfbqrh6JTHsXhY6qCaLAQyx25e0XE"))
        (symlink #$zig-dep-unpacked-imgui
                 (string-append #$output "/N-V-__8AAEbOfQBnvcFcCX2W5z7tDaN8vaNZGamEQtNOe0UI"))
        (symlink #$zig-dep-unpacked-iterm2-themes
                 (string-append #$output "/N-V-__8AAPy1AwDnEoq1ww42uq58nusIeQgR16W4-5SQZFIM"))
        (symlink #$zig-dep-unpacked-jetbrains-mono
                 (string-append #$output "/N-V-__8AAIC5lwAVPJJzxnCAahSvZTIlG-HhtOvnM1uh-66x"))
        (symlink #$zig-dep-unpacked-libpng
                 (string-append #$output "/N-V-__8AAJrvXQCqAT8Mg9o_tk6m0yf5Fz-gCNEOKLyTSerD"))
        (symlink #$zig-dep-unpacked-libxev
                 (string-append #$output "/libxev-0.0.0-86vtc4IcEwCqEYxEYoN_3KXmc6A9VLcm22aVImfvecYs"))
        (symlink #$zig-dep-unpacked-libxml2
                 (string-append #$output "/N-V-__8AAG3RoQEyRC2Vw7Qoro5SYBf62IHn3HjqtNVY6aWK"))
        (symlink #$zig-dep-unpacked-nerd-fonts-symbols-only
                 (string-append #$output "/N-V-__8AAMVLTABmYkLqhZPLXnMl-KyN38R8UVYqGrxqO26s"))
        (symlink #$zig-dep-unpacked-oniguruma
                 (string-append #$output "/N-V-__8AAHjwMQDBXnLq3Q2QhaivE0kE2aD138vtX2Bq1g7c"))
        (symlink #$zig-dep-unpacked-pixels
                 (string-append #$output "/N-V-__8AADYiAAB_80AWnH1AxXC0tql9thT-R-DYO1gBqTLc"))
        (symlink #$zig-dep-unpacked-plasma-wayland-protocols
                 (string-append #$output "/N-V-__8AAKYZBAB-CFHBKs3u4JkeiT4BMvyHu3Y5aaWF3Bbs"))
        (symlink #$zig-dep-unpacked-sentry
                 (string-append #$output "/N-V-__8AAPlZGwBEa-gxrcypGBZ2R8Bse4JYSfo_ul8i2jlG"))
        (symlink #$zig-dep-unpacked-spirv-cross
                 (string-append #$output "/N-V-__8AANb6pwD7O1WG6L5nvD_rNMvnSc9Cpg1ijSlTYywv"))
        (symlink #$zig-dep-unpacked-uucode-0-1-0
                 (string-append #$output "/uucode-0.1.0-ZZjBPj96QADXyt5sqwBJUnhaDYs_qBeeKijZvlRa0eqM"))
        (symlink #$zig-dep-unpacked-uucode-0-2-0
                 (string-append #$output "/uucode-0.2.0-ZZjBPqZVVABQepOqZHR7vV_NcaN-wats0IB6o-Exj6m9"))
        (symlink #$zig-dep-unpacked-vaxis
                 (string-append #$output "/vaxis-0.5.1-BWNV_LosCQAGmCCNOLljCIw6j6-yt53tji6n6rwJ2BhS"))
        (symlink #$zig-dep-unpacked-wayland
                 (string-append #$output "/N-V-__8AAKrHGAAs2shYq8UkE6bGcR1QJtLTyOE_lcosMn6t"))
        (symlink #$zig-dep-unpacked-wayland-protocols-1
                 (string-append #$output "/N-V-__8AAKw-DAAaV8bOAAGqA0-oD7o-HNIlPFYKRXSPT03S"))
        (symlink #$zig-dep-unpacked-wayland-protocols-2
                 (string-append #$output "/N-V-__8AAFdWDwA0ktbNUi9pFBHCRN4weXIgIfCrVjfGxqgA"))
        (symlink #$zig-dep-unpacked-wuffs
                 (string-append #$output "/N-V-__8AAAzZywE3s51XfsLbP9eyEw57ae9swYB9aGB6fCMs"))
        (symlink #$zig-dep-unpacked-z2d
                 (string-append #$output "/z2d-0.10.0-j5P_Hu-6FgBsZNgwphIqh17jDnj8_yPtD8yzjO6PpHRQ"))
        (symlink #$zig-dep-unpacked-zf
                 (string-append #$output "/zf-0.10.3-OIRy8RuJAACKA3Lohoumrt85nRbHwbpMcUaLES8vxDnh"))
        (symlink #$zig-dep-unpacked-zig-js
                 (string-append #$output "/zig_js-0.0.0-rjCAV-6GAADxFug7rDmPH-uM_XcnJ5NmuAMJCAscMjhi"))
        (symlink #$zig-dep-unpacked-zig-objc
                 (string-append #$output "/zig_objc-0.0.0-Ir_Sp5gTAQCvxxR7oVIrPXxXwsfKgVP7_wqoOQrZjFeK"))
        (symlink #$zig-dep-unpacked-zig-wayland
                 (string-append #$output "/wayland-0.5.0-dev-lQa1khrMAQDJDwYFKpdH3HizherB7sHo5dKMECfvxQHe"))
        (symlink #$zig-dep-unpacked-zigimg
                 (string-append #$output "/zigimg-0.1.0-8_eo2vHnEwCIVW34Q14Ec-xUlzIoVg86-7FU2ypPtxms"))
        (symlink #$zig-dep-unpacked-zlib
                 (string-append #$output "/N-V-__8AAB0eQwD-0MdOEBmz7intriBReIsIDNlukNVoNu6o"))
        )))

;; ---------------------------------------------------------------------------
;; Rust crate origins (from Cargo.lock)
;; ---------------------------------------------------------------------------

(define rust-adler2-2-0-1
  (origin (method url-fetch) (uri (crate-uri "adler2" "2.0.1"))
   (file-name "rust-adler2-2.0.1.tar.gz")
   (sha256 (base32 "1ymy18s9hs7ya1pjc9864l30wk8p2qfqdi7mhhcc5nfakxbij09j"))))

(define rust-aho-corasick-1-1-4
  (origin (method url-fetch) (uri (crate-uri "aho-corasick" "1.1.4"))
   (file-name "rust-aho-corasick-1.1.4.tar.gz")
   (sha256 (base32 "00a32wb2h07im3skkikc495jvncf62jl6s96vwc7bhi70h9imlyx"))))

(define rust-allocator-api2-0-2-21
  (origin (method url-fetch) (uri (crate-uri "allocator-api2" "0.2.21"))
   (file-name "rust-allocator-api2-0.2.21.tar.gz")
   (sha256 (base32 "08zrzs022xwndihvzdn78yqarv2b9696y67i6h78nla3ww87jgb8"))))

(define rust-anstyle-1-0-14
  (origin (method url-fetch) (uri (crate-uri "anstyle" "1.0.14"))
   (file-name "rust-anstyle-1.0.14.tar.gz")
   (sha256 (base32 "0030szmgj51fxkic1hpakxxgappxzwm6m154a3gfml83lq63l2wl"))))

(define rust-anyhow-1-0-102
  (origin (method url-fetch) (uri (crate-uri "anyhow" "1.0.102"))
   (file-name "rust-anyhow-1.0.102.tar.gz")
   (sha256 (base32 "0b447dra1v12z474c6z4jmicdmc5yxz5bakympdnij44ckw2s83z"))))

(define rust-atomic-0-6-1
  (origin (method url-fetch) (uri (crate-uri "atomic" "0.6.1"))
   (file-name "rust-atomic-0.6.1.tar.gz")
   (sha256 (base32 "0h43ljcgbl6vk62hs6yk7zg7qn3myzvpw8k7isb9nzhkbdvvz758"))))

(define rust-autocfg-1-5-0
  (origin (method url-fetch) (uri (crate-uri "autocfg" "1.5.0"))
   (file-name "rust-autocfg-1.5.0.tar.gz")
   (sha256 (base32 "1s77f98id9l4af4alklmzq46f21c980v13z2r1pcxx6bqgw0d1n0"))))

(define rust-base64-0-22-1
  (origin (method url-fetch) (uri (crate-uri "base64" "0.22.1"))
   (file-name "rust-base64-0.22.1.tar.gz")
   (sha256 (base32 "1imqzgh7bxcikp5vx3shqvw9j09g9ly0xr0jma0q66i52r7jbcvj"))))

(define rust-bincode-2-0-1
  (origin (method url-fetch) (uri (crate-uri "bincode" "2.0.1"))
   (file-name "rust-bincode-2.0.1.tar.gz")
   (sha256 (base32 "0h5pxp3dqkigjwy926a03sl69n9wv7aq4142a20kw9lhn3bzbsin"))))

(define rust-bincode_derive-2-0-1
  (origin (method url-fetch) (uri (crate-uri "bincode_derive" "2.0.1"))
   (file-name "rust-bincode_derive-2.0.1.tar.gz")
   (sha256 (base32 "029wmh26hq3hhs1gq629y0frn2pkl7ld061rk23fji8g8jd715dz"))))

(define rust-bit-set-0-5-3
  (origin (method url-fetch) (uri (crate-uri "bit-set" "0.5.3"))
   (file-name "rust-bit-set-0.5.3.tar.gz")
   (sha256 (base32 "1wcm9vxi00ma4rcxkl3pzzjli6ihrpn9cfdi0c5b4cvga2mxs007"))))

(define rust-bit-vec-0-6-3
  (origin (method url-fetch) (uri (crate-uri "bit-vec" "0.6.3"))
   (file-name "rust-bit-vec-0.6.3.tar.gz")
   (sha256 (base32 "1ywqjnv60cdh1slhz67psnp422md6jdliji6alq0gmly2xm9p7rl"))))

(define rust-bitflags-1-3-2
  (origin (method url-fetch) (uri (crate-uri "bitflags" "1.3.2"))
   (file-name "rust-bitflags-1.3.2.tar.gz")
   (sha256 (base32 "12ki6w8gn1ldq7yz9y680llwk5gmrhrzszaa17g1sbrw2r2qvwxy"))))

(define rust-bitflags-2-11-0
  (origin (method url-fetch) (uri (crate-uri "bitflags" "2.11.0"))
   (file-name "rust-bitflags-2.11.0.tar.gz")
   (sha256 (base32 "1bwjibwry5nfwsfm9kjg2dqx5n5nja9xymwbfl6svnn8jsz6ff44"))))

(define rust-block-buffer-0-10-4
  (origin (method url-fetch) (uri (crate-uri "block-buffer" "0.10.4"))
   (file-name "rust-block-buffer-0.10.4.tar.gz")
   (sha256 (base32 "0w9sa2ypmrsqqvc20nhwr75wbb5cjr4kkyhpjm1z1lv2kdicfy1h"))))

(define rust-block2-0-6-2
  (origin (method url-fetch) (uri (crate-uri "block2" "0.6.2"))
   (file-name "rust-block2-0.6.2.tar.gz")
   (sha256 (base32 "1xcfllzx6c3jc554nmb5qy6xmlkl6l6j5ib4wd11800n0n3rvsyd"))))

(define rust-bumpalo-3-20-2
  (origin (method url-fetch) (uri (crate-uri "bumpalo" "3.20.2"))
   (file-name "rust-bumpalo-3.20.2.tar.gz")
   (sha256 (base32 "1jrgxlff76k9glam0akhwpil2fr1w32gbjdf5hpipc7ld2c7h82x"))))

(define rust-bytemuck-1-25-0
  (origin (method url-fetch) (uri (crate-uri "bytemuck" "1.25.0"))
   (file-name "rust-bytemuck-1.25.0.tar.gz")
   (sha256 (base32 "1v1z32igg9zq49phb3fra0ax5r2inf3aw473vldnm886sx5vdvy8"))))

(define rust-bytes-1-11-1
  (origin (method url-fetch) (uri (crate-uri "bytes" "1.11.1"))
   (file-name "rust-bytes-1.11.1.tar.gz")
   (sha256 (base32 "0czwlhbq8z29wq0ia87yass2mzy1y0jcasjb8ghriiybnwrqfx0y"))))

(define rust-castaway-0-2-4
  (origin (method url-fetch) (uri (crate-uri "castaway" "0.2.4"))
   (file-name "rust-castaway-0.2.4.tar.gz")
   (sha256 (base32 "0nn5his5f8q20nkyg1nwb40xc19a08yaj4y76a8q2y3mdsmm3ify"))))

(define rust-cfg-if-1-0-4
  (origin (method url-fetch) (uri (crate-uri "cfg-if" "1.0.4"))
   (file-name "rust-cfg-if-1.0.4.tar.gz")
   (sha256 (base32 "008q28ajc546z5p2hcwdnckmg0hia7rnx52fni04bwqkzyrghc4k"))))

(define rust-cfg_aliases-0-1-1
  (origin (method url-fetch) (uri (crate-uri "cfg_aliases" "0.1.1"))
   (file-name "rust-cfg_aliases-0.1.1.tar.gz")
   (sha256 (base32 "17p821nc6jm830vzl2lmwz60g3a30hcm33nk6l257i1rjdqw85px"))))

(define rust-cfg_aliases-0-2-1
  (origin (method url-fetch) (uri (crate-uri "cfg_aliases" "0.2.1"))
   (file-name "rust-cfg_aliases-0.2.1.tar.gz")
   (sha256 (base32 "092pxdc1dbgjb6qvh83gk56rkic2n2ybm4yvy76cgynmzi3zwfk1"))))

(define rust-clap-4-6-1
  (origin (method url-fetch) (uri (crate-uri "clap" "4.6.1"))
   (file-name "rust-clap-4.6.1.tar.gz")
   (sha256 (base32 "0lcf88l7vlg796rrqr7wipbbmfa5sgsgx4211b7xmxxv8dz13nqx"))))

(define rust-clap_builder-4-6-0
  (origin (method url-fetch) (uri (crate-uri "clap_builder" "4.6.0"))
   (file-name "rust-clap_builder-4.6.0.tar.gz")
   (sha256 (base32 "17q6np22yxhh5y5v53y4l31ps3hlaz45mvz2n2nicr7n3c056jki"))))

(define rust-clap_complete-4-6-5
  (origin (method url-fetch) (uri (crate-uri "clap_complete" "4.6.5"))
   (file-name "rust-clap_complete-4.6.5.tar.gz")
   (sha256 (base32 "0wnp1w338vwf20sbaps13cjx452ijw2hybw3b6g1z09mvfzsk9z0"))))

(define rust-clap_lex-1-1-0
  (origin (method url-fetch) (uri (crate-uri "clap_lex" "1.1.0"))
   (file-name "rust-clap_lex-1.1.0.tar.gz")
   (sha256 (base32 "1ycqkpygnlqnndghhcxjb44lzl0nmgsia64x9581030yifxs7m68"))))

(define rust-compact_str-0-9-0
  (origin (method url-fetch) (uri (crate-uri "compact_str" "0.9.0"))
   (file-name "rust-compact_str-0.9.0.tar.gz")
   (sha256 (base32 "0ykhh2scg32lmzxak107pmby6fmnz7qbhsi9i8g9iknfl4ji7nrz"))))

(define rust-convert_case-0-10-0
  (origin (method url-fetch) (uri (crate-uri "convert_case" "0.10.0"))
   (file-name "rust-convert_case-0.10.0.tar.gz")
   (sha256 (base32 "1fff1x78mp2c233g68my0ag0zrmjdbym8bfyahjbfy4cxza5hd33"))))

(define rust-cpufeatures-0-2-17
  (origin (method url-fetch) (uri (crate-uri "cpufeatures" "0.2.17"))
   (file-name "rust-cpufeatures-0.2.17.tar.gz")
   (sha256 (base32 "10023dnnaghhdl70xcds12fsx2b966sxbxjq5sxs49mvxqw5ivar"))))

(define rust-crc32fast-1-5-0
  (origin (method url-fetch) (uri (crate-uri "crc32fast" "1.5.0"))
   (file-name "rust-crc32fast-1.5.0.tar.gz")
   (sha256 (base32 "04d51liy8rbssra92p0qnwjw8i9rm9c4m3bwy19wjamz1k4w30cl"))))

(define rust-crossterm-0-29-0
  (origin (method url-fetch) (uri (crate-uri "crossterm" "0.29.0"))
   (file-name "rust-crossterm-0.29.0.tar.gz")
   (sha256 (base32 "0yzqxxd90k7d2ac26xq1awsznsaq0qika2nv1ik3p0vzqvjg5ffq"))))

(define rust-crossterm_winapi-0-9-1
  (origin (method url-fetch) (uri (crate-uri "crossterm_winapi" "0.9.1"))
   (file-name "rust-crossterm_winapi-0.9.1.tar.gz")
   (sha256 (base32 "0axbfb2ykbwbpf1hmxwpawwfs8wvmkcka5m561l7yp36ldi7rpdc"))))

(define rust-crypto-common-0-1-7
  (origin (method url-fetch) (uri (crate-uri "crypto-common" "0.1.7"))
   (file-name "rust-crypto-common-0.1.7.tar.gz")
   (sha256 (base32 "02nn2rhfy7kvdkdjl457q2z0mklcvj9h662xrq6dzhfialh2kj3q"))))

(define rust-csscolorparser-0-6-2
  (origin (method url-fetch) (uri (crate-uri "csscolorparser" "0.6.2"))
   (file-name "rust-csscolorparser-0.6.2.tar.gz")
   (sha256 (base32 "1gxh11hajx96mf5sd0az6mfsxdryfqvcfcphny3yfbfscqq7sapb"))))

(define rust-ctrlc-3-5-2
  (origin (method url-fetch) (uri (crate-uri "ctrlc" "3.5.2"))
   (file-name "rust-ctrlc-3.5.2.tar.gz")
   (sha256 (base32 "0qh1lvlr6k58dliqllx1n7mjfwp1mzr607bks3r9m0a5msrgmcg0"))))

(define rust-darling-0-23-0
  (origin (method url-fetch) (uri (crate-uri "darling" "0.23.0"))
   (file-name "rust-darling-0.23.0.tar.gz")
   (sha256 (base32 "179fj6p6ajw4dnkrik51wjhifxwy02x5zhligyymcb905zd17bi5"))))

(define rust-darling_core-0-23-0
  (origin (method url-fetch) (uri (crate-uri "darling_core" "0.23.0"))
   (file-name "rust-darling_core-0.23.0.tar.gz")
   (sha256 (base32 "1c033vrks38vpw8kwgd5w088dsr511kfz55n9db56prkgh7sarcq"))))

(define rust-darling_macro-0-23-0
  (origin (method url-fetch) (uri (crate-uri "darling_macro" "0.23.0"))
   (file-name "rust-darling_macro-0.23.0.tar.gz")
   (sha256 (base32 "13fvzji9xyp304mgq720z5l0xgm54qj68jibwscagkynggn88fdc"))))

(define rust-deltae-0-3-2
  (origin (method url-fetch) (uri (crate-uri "deltae" "0.3.2"))
   (file-name "rust-deltae-0.3.2.tar.gz")
   (sha256 (base32 "1d3hw9hpvicl9x0x34jr2ybjk5g5ym1lhbyz6zj31110gq8zaaap"))))

(define rust-deranged-0-5-8
  (origin (method url-fetch) (uri (crate-uri "deranged" "0.5.8"))
   (file-name "rust-deranged-0.5.8.tar.gz")
   (sha256 (base32 "0711df3w16vx80k55ivkwzwswziinj4dz05xci3rvmn15g615n3w"))))

(define rust-derive_more-2-1-1
  (origin (method url-fetch) (uri (crate-uri "derive_more" "2.1.1"))
   (file-name "rust-derive_more-2.1.1.tar.gz")
   (sha256 (base32 "0d5i10l4aff744jw7v4n8g6cv15rjk5mp0f1z522pc2nj7jfjlfp"))))

(define rust-derive_more-impl-2-1-1
  (origin (method url-fetch) (uri (crate-uri "derive_more-impl" "2.1.1"))
   (file-name "rust-derive_more-impl-2.1.1.tar.gz")
   (sha256 (base32 "1jwdp836vymp35d7mfvvalplkdgk2683nv3zjlx65n1194k9g6kr"))))

(define rust-digest-0-10-7
  (origin (method url-fetch) (uri (crate-uri "digest" "0.10.7"))
   (file-name "rust-digest-0.10.7.tar.gz")
   (sha256 (base32 "14p2n6ih29x81akj097lvz7wi9b6b9hvls0lwrv7b6xwyy0s5ncy"))))

(define rust-dispatch2-0-3-1
  (origin (method url-fetch) (uri (crate-uri "dispatch2" "0.3.1"))
   (file-name "rust-dispatch2-0.3.1.tar.gz")
   (sha256 (base32 "0f5xmnbzpaz1g80m27kd804p75nswh0ikb6wvqh4ba3x9rz3c3hy"))))

(define rust-doctest-file-1-1-1
  (origin (method url-fetch) (uri (crate-uri "doctest-file" "1.1.1"))
   (file-name "rust-doctest-file-1.1.1.tar.gz")
   (sha256 (base32 "0nfkscv8gf3ixhradrmwm3f2p6sc0ab0psah7c8976ha9zkh9ny2"))))

(define rust-document-features-0-2-12
  (origin (method url-fetch) (uri (crate-uri "document-features" "0.2.12"))
   (file-name "rust-document-features-0.2.12.tar.gz")
   (sha256 (base32 "0qcgpialq3zgvjmsvar9n6v10rfbv6mk6ajl46dd4pj5hn3aif6l"))))

(define rust-downcast-rs-1-2-1
  (origin (method url-fetch) (uri (crate-uri "downcast-rs" "1.2.1"))
   (file-name "rust-downcast-rs-1.2.1.tar.gz")
   (sha256 (base32 "1lmrq383d1yszp7mg5i7i56b17x2lnn3kb91jwsq0zykvg2jbcvm"))))

(define rust-dyn-clone-1-0-20
  (origin (method url-fetch) (uri (crate-uri "dyn-clone" "1.0.20"))
   (file-name "rust-dyn-clone-1.0.20.tar.gz")
   (sha256 (base32 "0m956cxcg8v2n8kmz6xs5zl13k2fak3zkapzfzzp7pxih6hix26h"))))

(define rust-either-1-15-0
  (origin (method url-fetch) (uri (crate-uri "either" "1.15.0"))
   (file-name "rust-either-1.15.0.tar.gz")
   (sha256 (base32 "069p1fknsmzn9llaizh77kip0pqmcwpdsykv2x30xpjyija5gis8"))))

(define rust-equivalent-1-0-2
  (origin (method url-fetch) (uri (crate-uri "equivalent" "1.0.2"))
   (file-name "rust-equivalent-1.0.2.tar.gz")
   (sha256 (base32 "03swzqznragy8n0x31lqc78g2af054jwivp7lkrbrc0khz74lyl7"))))

(define rust-errno-0-3-14
  (origin (method url-fetch) (uri (crate-uri "errno" "0.3.14"))
   (file-name "rust-errno-0.3.14.tar.gz")
   (sha256 (base32 "1szgccmh8vgryqyadg8xd58mnwwicf39zmin3bsn63df2wbbgjir"))))

(define rust-euclid-0-22-14
  (origin (method url-fetch) (uri (crate-uri "euclid" "0.22.14"))
   (file-name "rust-euclid-0.22.14.tar.gz")
   (sha256 (base32 "01ksjl4vb8ms89laswnjpld3z4n6c1s7qlqq0djx3imiwdjm787i"))))

(define rust-fancy-regex-0-11-0
  (origin (method url-fetch) (uri (crate-uri "fancy-regex" "0.11.0"))
   (file-name "rust-fancy-regex-0.11.0.tar.gz")
   (sha256 (base32 "18j0mmzfycibhxhhhfja00dxd1vf8x5c28lbry224574h037qpxr"))))

(define rust-fdeflate-0-3-7
  (origin (method url-fetch) (uri (crate-uri "fdeflate" "0.3.7"))
   (file-name "rust-fdeflate-0.3.7.tar.gz")
   (sha256 (base32 "130ga18vyxbb5idbgi07njymdaavvk6j08yh1dfarm294ssm6s0y"))))

(define rust-filedescriptor-0-8-3
  (origin (method url-fetch) (uri (crate-uri "filedescriptor" "0.8.3"))
   (file-name "rust-filedescriptor-0.8.3.tar.gz")
   (sha256 (base32 "0bb8qqa9h9sj2mzf09yqxn260qkcqvmhmyrmdjvyxcn94knmh1z4"))))

(define rust-finl_unicode-1-4-0
  (origin (method url-fetch) (uri (crate-uri "finl_unicode" "1.4.0"))
   (file-name "rust-finl_unicode-1.4.0.tar.gz")
   (sha256 (base32 "1md4j32sa8g6y7q9yphpslhhjdjxig1bczkjp8mxccz5lv1xsi4q"))))

(define rust-fixedbitset-0-4-2
  (origin (method url-fetch) (uri (crate-uri "fixedbitset" "0.4.2"))
   (file-name "rust-fixedbitset-0.4.2.tar.gz")
   (sha256 (base32 "101v41amgv5n9h4hcghvrbfk5vrncx1jwm35rn5szv4rk55i7rqc"))))

(define rust-flate2-1-1-9
  (origin (method url-fetch) (uri (crate-uri "flate2" "1.1.9"))
   (file-name "rust-flate2-1.1.9.tar.gz")
   (sha256 (base32 "0g2pb7cxnzcbzrj8bw4v6gpqqp21aycmf6d84rzb6j748qkvlgw4"))))

(define rust-fnv-1-0-7
  (origin (method url-fetch) (uri (crate-uri "fnv" "1.0.7"))
   (file-name "rust-fnv-1.0.7.tar.gz")
   (sha256 (base32 "1hc2mcqha06aibcaza94vbi81j6pr9a1bbxrxjfhc91zin8yr7iz"))))

(define rust-foldhash-0-1-5
  (origin (method url-fetch) (uri (crate-uri "foldhash" "0.1.5"))
   (file-name "rust-foldhash-0.1.5.tar.gz")
   (sha256 (base32 "1wisr1xlc2bj7hk4rgkcjkz3j2x4dhd1h9lwk7mj8p71qpdgbi6r"))))

(define rust-foldhash-0-2-0
  (origin (method url-fetch) (uri (crate-uri "foldhash" "0.2.0"))
   (file-name "rust-foldhash-0.2.0.tar.gz")
   (sha256 (base32 "1nvgylb099s11xpfm1kn2wcsql080nqmnhj1l25bp3r2b35j9kkp"))))

(define rust-generic-array-0-14-7
  (origin (method url-fetch) (uri (crate-uri "generic-array" "0.14.7"))
   (file-name "rust-generic-array-0.14.7.tar.gz")
   (sha256 (base32 "16lyyrzrljfq424c3n8kfwkqihlimmsg5nhshbbp48np3yjrqr45"))))

(define rust-getrandom-0-3-4
  (origin (method url-fetch) (uri (crate-uri "getrandom" "0.3.4"))
   (file-name "rust-getrandom-0.3.4.tar.gz")
   (sha256 (base32 "1zbpvpicry9lrbjmkd4msgj3ihff1q92i334chk7pzf46xffz7c9"))))

(define rust-getrandom-0-4-2
  (origin (method url-fetch) (uri (crate-uri "getrandom" "0.4.2"))
   (file-name "rust-getrandom-0.4.2.tar.gz")
   (sha256 (base32 "0mb5833hf9pvn9dhvxjgfg5dx0m77g8wavvjdpvpnkp9fil1xr8d"))))

(define rust-hashbrown-0-15-5
  (origin (method url-fetch) (uri (crate-uri "hashbrown" "0.15.5"))
   (file-name "rust-hashbrown-0.15.5.tar.gz")
   (sha256 (base32 "189qaczmjxnikm9db748xyhiw04kpmhm9xj9k9hg0sgx7pjwyacj"))))

(define rust-hashbrown-0-16-1
  (origin (method url-fetch) (uri (crate-uri "hashbrown" "0.16.1"))
   (file-name "rust-hashbrown-0.16.1.tar.gz")
   (sha256 (base32 "004i3njw38ji3bzdp9z178ba9x3k0c1pgy8x69pj7yfppv4iq7c4"))))

(define rust-heck-0-5-0
  (origin (method url-fetch) (uri (crate-uri "heck" "0.5.0"))
   (file-name "rust-heck-0.5.0.tar.gz")
   (sha256 (base32 "1sjmpsdl8czyh9ywl3qcsfsq9a307dg4ni2vnlwgnzzqhc4y0113"))))

(define rust-hex-0-4-3
  (origin (method url-fetch) (uri (crate-uri "hex" "0.4.3"))
   (file-name "rust-hex-0.4.3.tar.gz")
   (sha256 (base32 "0w1a4davm1lgzpamwnba907aysmlrnygbqmfis2mqjx5m552a93z"))))

(define rust-id-arena-2-3-0
  (origin (method url-fetch) (uri (crate-uri "id-arena" "2.3.0"))
   (file-name "rust-id-arena-2.3.0.tar.gz")
   (sha256 (base32 "0m6rs0jcaj4mg33gkv98d71w3hridghp5c4yr928hplpkgbnfc1x"))))

(define rust-ident_case-1-0-1
  (origin (method url-fetch) (uri (crate-uri "ident_case" "1.0.1"))
   (file-name "rust-ident_case-1.0.1.tar.gz")
   (sha256 (base32 "0fac21q6pwns8gh1hz3nbq15j8fi441ncl6w4vlnd1cmc55kiq5r"))))

(define rust-indexmap-2-13-0
  (origin (method url-fetch) (uri (crate-uri "indexmap" "2.13.0"))
   (file-name "rust-indexmap-2.13.0.tar.gz")
   (sha256 (base32 "05qh5c4h2hrnyypphxpwflk45syqbzvqsvvyxg43mp576w2ff53p"))))

(define rust-indoc-2-0-7
  (origin (method url-fetch) (uri (crate-uri "indoc" "2.0.7"))
   (file-name "rust-indoc-2.0.7.tar.gz")
   (sha256 (base32 "01np60qdq6lvgh8ww2caajn9j4dibx9n58rvzf7cya1jz69mrkvr"))))

(define rust-instability-0-3-12
  (origin (method url-fetch) (uri (crate-uri "instability" "0.3.12"))
   (file-name "rust-instability-0.3.12.tar.gz")
   (sha256 (base32 "0wc98mr44w5k1y6pib2x0kydmhbff8gkfgiw36ls684ry47ddcjy"))))

(define rust-interprocess-2-4-2
  (origin (method url-fetch) (uri (crate-uri "interprocess" "2.4.2"))
   (file-name "rust-interprocess-2.4.2.tar.gz")
   (sha256 (base32 "0nsr54v0i2ac0cfnccf5ks8vcdhxj7nw3rcgdaq7mjq06is274q6"))))

(define rust-itertools-0-14-0
  (origin (method url-fetch) (uri (crate-uri "itertools" "0.14.0"))
   (file-name "rust-itertools-0.14.0.tar.gz")
   (sha256 (base32 "118j6l1vs2mx65dqhwyssbrxpawa90886m3mzafdvyip41w2q69b"))))

(define rust-itoa-1-0-18
  (origin (method url-fetch) (uri (crate-uri "itoa" "1.0.18"))
   (file-name "rust-itoa-1.0.18.tar.gz")
   (sha256 (base32 "10jnd1vpfkb8kj38rlkn2a6k02afvj3qmw054dfpzagrpl6achlg"))))

(define rust-js-sys-0-3-91
  (origin (method url-fetch) (uri (crate-uri "js-sys" "0.3.91"))
   (file-name "rust-js-sys-0.3.91.tar.gz")
   (sha256 (base32 "171rzgq33wc1nxkgnvhlqqwwnrifs13mg3jjpjj5nf1z0yvib5xl"))))

(define rust-kasuari-0-4-12
  (origin (method url-fetch) (uri (crate-uri "kasuari" "0.4.12"))
   (file-name "rust-kasuari-0.4.12.tar.gz")
   (sha256 (base32 "1688q59qh1mxa28k00lnddn73mh3jcdmj3yrc7l99k23c5yhbrdx"))))

(define rust-lab-0-11-0
  (origin (method url-fetch) (uri (crate-uri "lab" "0.11.0"))
   (file-name "rust-lab-0.11.0.tar.gz")
   (sha256 (base32 "13ymsn5cwl5i9pmp5mfmbap7q688dcp9a17q82crkvb784yifdmz"))))

(define rust-lazy_static-1-5-0
  (origin (method url-fetch) (uri (crate-uri "lazy_static" "1.5.0"))
   (file-name "rust-lazy_static-1.5.0.tar.gz")
   (sha256 (base32 "1zk6dqqni0193xg6iijh7i3i44sryglwgvx20spdvwk3r6sbrlmv"))))

(define rust-leb128fmt-0-1-0
  (origin (method url-fetch) (uri (crate-uri "leb128fmt" "0.1.0"))
   (file-name "rust-leb128fmt-0.1.0.tar.gz")
   (sha256 (base32 "1chxm1484a0bly6anh6bd7a99sn355ymlagnwj3yajafnpldkv89"))))

(define rust-libc-0-2-183
  (origin (method url-fetch) (uri (crate-uri "libc" "0.2.183"))
   (file-name "rust-libc-0.2.183.tar.gz")
   (sha256 (base32 "17c9gyia7rrzf9gsssvk3vq9ca2jp6rh32fsw6ciarpn5djlddmm"))))

(define rust-line-clipping-0-3-5
  (origin (method url-fetch) (uri (crate-uri "line-clipping" "0.3.5"))
   (file-name "rust-line-clipping-0.3.5.tar.gz")
   (sha256 (base32 "0jlakbyjc5sh4j2lx2glyjar3wqq9mqifkdzbhvhkgyxk17f8kaz"))))

(define rust-linux-raw-sys-0-12-1
  (origin (method url-fetch) (uri (crate-uri "linux-raw-sys" "0.12.1"))
   (file-name "rust-linux-raw-sys-0.12.1.tar.gz")
   (sha256 (base32 "0lwasljrqxjjfk9l2j8lyib1babh2qjlnhylqzl01nihw14nk9ij"))))

(define rust-litrs-1-0-0
  (origin (method url-fetch) (uri (crate-uri "litrs" "1.0.0"))
   (file-name "rust-litrs-1.0.0.tar.gz")
   (sha256 (base32 "14p0kzzkavnngvybl88nvfwv031cc2qx4vaxpfwsiifm8grdglqi"))))

(define rust-lock_api-0-4-14
  (origin (method url-fetch) (uri (crate-uri "lock_api" "0.4.14"))
   (file-name "rust-lock_api-0.4.14.tar.gz")
   (sha256 (base32 "0rg9mhx7vdpajfxvdjmgmlyrn20ligzqvn8ifmaz7dc79gkrjhr2"))))

(define rust-log-0-4-29
  (origin (method url-fetch) (uri (crate-uri "log" "0.4.29"))
   (file-name "rust-log-0.4.29.tar.gz")
   (sha256 (base32 "15q8j9c8g5zpkcw0hnd6cf2z7fxqnvsjh3rw5mv5q10r83i34l2y"))))

(define rust-lru-0-16-3
  (origin (method url-fetch) (uri (crate-uri "lru" "0.16.3"))
   (file-name "rust-lru-0.16.3.tar.gz")
   (sha256 (base32 "14z5yxcp3f63lgw8yxr486g9yz7cfqbmkadfwgw36vy0jbslgp51"))))

(define rust-mac_address-1-1-8
  (origin (method url-fetch) (uri (crate-uri "mac_address" "1.1.8"))
   (file-name "rust-mac_address-1.1.8.tar.gz")
   (sha256 (base32 "00r3n18mxglq1dzshnm0vxk1fgsp3c2hd08w6hfcqdp8ymmv5bn0"))))

(define rust-matchers-0-2-0
  (origin (method url-fetch) (uri (crate-uri "matchers" "0.2.0"))
   (file-name "rust-matchers-0.2.0.tar.gz")
   (sha256 (base32 "1sasssspdj2vwcwmbq3ra18d3qniapkimfcbr47zmx6750m5llni"))))

(define rust-memchr-2-8-0
  (origin (method url-fetch) (uri (crate-uri "memchr" "2.8.0"))
   (file-name "rust-memchr-2.8.0.tar.gz")
   (sha256 (base32 "0y9zzxcqxvdqg6wyag7vc3h0blhdn7hkq164bxyx2vph8zs5ijpq"))))

(define rust-memmem-0-1-1
  (origin (method url-fetch) (uri (crate-uri "memmem" "0.1.1"))
   (file-name "rust-memmem-0.1.1.tar.gz")
   (sha256 (base32 "05ccifqgxdfxk6yls41ljabcccsz3jz6549l1h3cwi17kr494jm6"))))

(define rust-memoffset-0-9-1
  (origin (method url-fetch) (uri (crate-uri "memoffset" "0.9.1"))
   (file-name "rust-memoffset-0.9.1.tar.gz")
   (sha256 (base32 "12i17wh9a9plx869g7j4whf62xw68k5zd4k0k5nh6ys5mszid028"))))

(define rust-minimal-lexical-0-2-1
  (origin (method url-fetch) (uri (crate-uri "minimal-lexical" "0.2.1"))
   (file-name "rust-minimal-lexical-0.2.1.tar.gz")
   (sha256 (base32 "16ppc5g84aijpri4jzv14rvcnslvlpphbszc7zzp6vfkddf4qdb8"))))

(define rust-miniz_oxide-0-8-9
  (origin (method url-fetch) (uri (crate-uri "miniz_oxide" "0.8.9"))
   (file-name "rust-miniz_oxide-0.8.9.tar.gz")
   (sha256 (base32 "05k3pdg8bjjzayq3rf0qhpirq9k37pxnasfn4arbs17phqn6m9qz"))))

(define rust-mio-1-1-1
  (origin (method url-fetch) (uri (crate-uri "mio" "1.1.1"))
   (file-name "rust-mio-1.1.1.tar.gz")
   (sha256 (base32 "1z2phpalqbdgihrcjp8y09l3kgq6309jnhnr6h11l9s7mnqcm6x6"))))

(define rust-nix-0-28-0
  (origin (method url-fetch) (uri (crate-uri "nix" "0.28.0"))
   (file-name "rust-nix-0.28.0.tar.gz")
   (sha256 (base32 "1r0rylax4ycx3iqakwjvaa178jrrwiiwghcw95ndzy72zk25c8db"))))

(define rust-nix-0-29-0
  (origin (method url-fetch) (uri (crate-uri "nix" "0.29.0"))
   (file-name "rust-nix-0.29.0.tar.gz")
   (sha256 (base32 "0ikvn7s9r2lrfdm3mx1h7nbfjvcc6s9vxdzw7j5xfkd2qdnp9qki"))))

(define rust-nix-0-31-2
  (origin (method url-fetch) (uri (crate-uri "nix" "0.31.2"))
   (file-name "rust-nix-0.31.2.tar.gz")
   (sha256 (base32 "1lzmcqcnb9z8l4aq5ympx71bcwc0y5yf7d8jv6hnn7hc682hfvax"))))

(define rust-nom-7-1-3
  (origin (method url-fetch) (uri (crate-uri "nom" "7.1.3"))
   (file-name "rust-nom-7.1.3.tar.gz")
   (sha256 (base32 "0jha9901wxam390jcf5pfa0qqfrgh8li787jx2ip0yk5b8y9hwyj"))))

(define rust-nu-ansi-term-0-50-3
  (origin (method url-fetch) (uri (crate-uri "nu-ansi-term" "0.50.3"))
   (file-name "rust-nu-ansi-term-0.50.3.tar.gz")
   (sha256 (base32 "1ra088d885lbd21q1bxgpqdlk1zlndblmarn948jz2a40xsbjmvr"))))

(define rust-num-conv-0-2-1
  (origin (method url-fetch) (uri (crate-uri "num-conv" "0.2.1"))
   (file-name "rust-num-conv-0.2.1.tar.gz")
   (sha256 (base32 "0rqrr29brafaa2za352pbmhkk556n7f8z9rrkgmjp1idvdl3fry6"))))

(define rust-num-derive-0-4-2
  (origin (method url-fetch) (uri (crate-uri "num-derive" "0.4.2"))
   (file-name "rust-num-derive-0.4.2.tar.gz")
   (sha256 (base32 "00p2am9ma8jgd2v6xpsz621wc7wbn1yqi71g15gc3h67m7qmafgd"))))

(define rust-num-traits-0-2-19
  (origin (method url-fetch) (uri (crate-uri "num-traits" "0.2.19"))
   (file-name "rust-num-traits-0.2.19.tar.gz")
   (sha256 (base32 "0h984rhdkkqd4ny9cif7y2azl3xdfb7768hb9irhpsch4q3gq787"))))

(define rust-num_threads-0-1-7
  (origin (method url-fetch) (uri (crate-uri "num_threads" "0.1.7"))
   (file-name "rust-num_threads-0.1.7.tar.gz")
   (sha256 (base32 "1ngajbmhrgyhzrlc4d5ga9ych1vrfcvfsiqz6zv0h2dpr2wrhwsw"))))

(define rust-objc2-0-6-4
  (origin (method url-fetch) (uri (crate-uri "objc2" "0.6.4"))
   (file-name "rust-objc2-0.6.4.tar.gz")
   (sha256 (base32 "17x8qpl512frscfqbmgjr20kg3y4r0xdqxphja17dz5f0znsh4is"))))

(define rust-objc2-encode-4-1-0
  (origin (method url-fetch) (uri (crate-uri "objc2-encode" "4.1.0"))
   (file-name "rust-objc2-encode-4.1.0.tar.gz")
   (sha256 (base32 "0cqckp4cpf68mxyc2zgnazj8klv0z395nsgbafa61cjgsyyan9gg"))))

(define rust-once_cell-1-21-4
  (origin (method url-fetch) (uri (crate-uri "once_cell" "1.21.4"))
   (file-name "rust-once_cell-1.21.4.tar.gz")
   (sha256 (base32 "0l1v676wf71kjg2khch4dphwh1jp3291ffiymr2mvy1kxd5kwz4z"))))

(define rust-ordered-float-4-6-0
  (origin (method url-fetch) (uri (crate-uri "ordered-float" "4.6.0"))
   (file-name "rust-ordered-float-4.6.0.tar.gz")
   (sha256 (base32 "0ldrcgilsiijd141vw51fbkziqmh5fpllil3ydhirjm67wdixdvv"))))

(define rust-parking_lot-0-12-5
  (origin (method url-fetch) (uri (crate-uri "parking_lot" "0.12.5"))
   (file-name "rust-parking_lot-0.12.5.tar.gz")
   (sha256 (base32 "06jsqh9aqmc94j2rlm8gpccilqm6bskbd67zf6ypfc0f4m9p91ck"))))

(define rust-parking_lot_core-0-9-12
  (origin (method url-fetch) (uri (crate-uri "parking_lot_core" "0.9.12"))
   (file-name "rust-parking_lot_core-0.9.12.tar.gz")
   (sha256 (base32 "1hb4rggy70fwa1w9nb0svbyflzdc69h047482v2z3sx2hmcnh896"))))

(define rust-pest-2-8-6
  (origin (method url-fetch) (uri (crate-uri "pest" "2.8.6"))
   (file-name "rust-pest-2.8.6.tar.gz")
   (sha256 (base32 "0qm6kpqsbn2p6vkd7v4j3g7wsjby2ip6di1h6kx7vlq921h8r170"))))

(define rust-pest_derive-2-8-6
  (origin (method url-fetch) (uri (crate-uri "pest_derive" "2.8.6"))
   (file-name "rust-pest_derive-2.8.6.tar.gz")
   (sha256 (base32 "0xzysvcyfs0pkn2801rg811y83jx2rvpqnjxs47c3ri1xbqqdx0i"))))

(define rust-pest_generator-2-8-6
  (origin (method url-fetch) (uri (crate-uri "pest_generator" "2.8.6"))
   (file-name "rust-pest_generator-2.8.6.tar.gz")
   (sha256 (base32 "0kzrcik2ww0qh84jlv8xqc0zmzgl3xy41vf1cfli1chkgdjc8h40"))))

(define rust-pest_meta-2-8-6
  (origin (method url-fetch) (uri (crate-uri "pest_meta" "2.8.6"))
   (file-name "rust-pest_meta-2.8.6.tar.gz")
   (sha256 (base32 "08126skq2lxysinp6v917niszhnnh6d6a9kg2i0a28b0sdlmr0c9"))))

(define rust-phf-0-11-3
  (origin (method url-fetch) (uri (crate-uri "phf" "0.11.3"))
   (file-name "rust-phf-0.11.3.tar.gz")
   (sha256 (base32 "0y6hxp1d48rx2434wgi5g8j1pr8s5jja29ha2b65435fh057imhz"))))

(define rust-phf_codegen-0-11-3
  (origin (method url-fetch) (uri (crate-uri "phf_codegen" "0.11.3"))
   (file-name "rust-phf_codegen-0.11.3.tar.gz")
   (sha256 (base32 "0si1n6zr93kzjs3wah04ikw8z6npsr39jw4dam8yi9czg2609y5f"))))

(define rust-phf_generator-0-11-3
  (origin (method url-fetch) (uri (crate-uri "phf_generator" "0.11.3"))
   (file-name "rust-phf_generator-0.11.3.tar.gz")
   (sha256 (base32 "0gc4np7s91ynrgw73s2i7iakhb4lzdv1gcyx7yhlc0n214a2701w"))))

(define rust-phf_macros-0-11-3
  (origin (method url-fetch) (uri (crate-uri "phf_macros" "0.11.3"))
   (file-name "rust-phf_macros-0.11.3.tar.gz")
   (sha256 (base32 "05kjfbyb439344rhmlzzw0f9bwk9fp95mmw56zs7yfn1552c0jpq"))))

(define rust-phf_shared-0-11-3
  (origin (method url-fetch) (uri (crate-uri "phf_shared" "0.11.3"))
   (file-name "rust-phf_shared-0.11.3.tar.gz")
   (sha256 (base32 "1rallyvh28jqd9i916gk5gk2igdmzlgvv5q0l3xbf3m6y8pbrsk7"))))

(define rust-pin-project-lite-0-2-17
  (origin (method url-fetch) (uri (crate-uri "pin-project-lite" "0.2.17"))
   (file-name "rust-pin-project-lite-0.2.17.tar.gz")
   (sha256 (base32 "1kfmwvs271si96zay4mm8887v5khw0c27jc9srw1a75ykvgj54x8"))))

(define rust-png-0-17-16
  (origin (method url-fetch) (uri (crate-uri "png" "0.17.16"))
   (file-name "rust-png-0.17.16.tar.gz")
   (sha256 (base32 "09kmkms9fmkbkarw0lnf0scqvjwwg3r7riddag0i3q39r0pil5c2"))))

(define rust-portable-atomic-1-13-1
  (origin (method url-fetch) (uri (crate-uri "portable-atomic" "1.13.1"))
   (file-name "rust-portable-atomic-1.13.1.tar.gz")
   (sha256 (base32 "0j8vlar3n5acyigq8q6f4wjx3k3s5yz0rlpqrv76j73gi5qr8fn3"))))

(define rust-powerfmt-0-2-0
  (origin (method url-fetch) (uri (crate-uri "powerfmt" "0.2.0"))
   (file-name "rust-powerfmt-0.2.0.tar.gz")
   (sha256 (base32 "14ckj2xdpkhv3h6l5sdmb9f1d57z8hbfpdldjc2vl5givq2y77j3"))))

(define rust-prettyplease-0-2-37
  (origin (method url-fetch) (uri (crate-uri "prettyplease" "0.2.37"))
   (file-name "rust-prettyplease-0.2.37.tar.gz")
   (sha256 (base32 "0azn11i1kh0byabhsgab6kqs74zyrg69xkirzgqyhz6xmjnsi727"))))

(define rust-proc-macro2-1-0-106
  (origin (method url-fetch) (uri (crate-uri "proc-macro2" "1.0.106"))
   (file-name "rust-proc-macro2-1.0.106.tar.gz")
   (sha256 (base32 "0d09nczyaj67x4ihqr5p7gxbkz38gxhk4asc0k8q23g9n85hzl4g"))))

(define rust-quote-1-0-45
  (origin (method url-fetch) (uri (crate-uri "quote" "1.0.45"))
   (file-name "rust-quote-1.0.45.tar.gz")
   (sha256 (base32 "095rb5rg7pbnwdp6v8w5jw93wndwyijgci1b5lw8j1h5cscn3wj1"))))

(define rust-r-efi-5-3-0
  (origin (method url-fetch) (uri (crate-uri "r-efi" "5.3.0"))
   (file-name "rust-r-efi-5.3.0.tar.gz")
   (sha256 (base32 "03sbfm3g7myvzyylff6qaxk4z6fy76yv860yy66jiswc2m6b7kb9"))))

(define rust-r-efi-6-0-0
  (origin (method url-fetch) (uri (crate-uri "r-efi" "6.0.0"))
   (file-name "rust-r-efi-6.0.0.tar.gz")
   (sha256 (base32 "1gyrl2k5fyzj9k7kchg2n296z5881lg7070msabid09asp3wkp7q"))))

(define rust-rand-0-8-5
  (origin (method url-fetch) (uri (crate-uri "rand" "0.8.5"))
   (file-name "rust-rand-0.8.5.tar.gz")
   (sha256 (base32 "013l6931nn7gkc23jz5mm3qdhf93jjf0fg64nz2lp4i51qd8vbrl"))))

(define rust-rand_core-0-6-4
  (origin (method url-fetch) (uri (crate-uri "rand_core" "0.6.4"))
   (file-name "rust-rand_core-0.6.4.tar.gz")
   (sha256 (base32 "0b4j2v4cb5krak1pv6kakv4sz6xcwbrmy2zckc32hsigbrwy82zc"))))

(define rust-ratatui-0-30-0
  (origin (method url-fetch) (uri (crate-uri "ratatui" "0.30.0"))
   (file-name "rust-ratatui-0.30.0.tar.gz")
   (sha256 (base32 "1g36h96fnr8ay7bmwplxsfa5xzsp0pdaxny8s5a68i54igxngkni"))))

(define rust-ratatui-core-0-1-0
  (origin (method url-fetch) (uri (crate-uri "ratatui-core" "0.1.0"))
   (file-name "rust-ratatui-core-0.1.0.tar.gz")
   (sha256 (base32 "14y2pv5njy7kpzjsfn20a8vmjbhnfq5vgbgppxrszjljkahdxy2y"))))

(define rust-ratatui-crossterm-0-1-0
  (origin (method url-fetch) (uri (crate-uri "ratatui-crossterm" "0.1.0"))
   (file-name "rust-ratatui-crossterm-0.1.0.tar.gz")
   (sha256 (base32 "1cslvh75a29gdmz84s5sjaqd61k4s0fkjsjwn8gi4k1bcngrnz2p"))))

(define rust-ratatui-macros-0-7-0
  (origin (method url-fetch) (uri (crate-uri "ratatui-macros" "0.7.0"))
   (file-name "rust-ratatui-macros-0.7.0.tar.gz")
   (sha256 (base32 "1x1nr4wyyhchms9chj10b3wk7ribfvmd14xps2wlngp82cm39wd7"))))

(define rust-ratatui-termwiz-0-1-0
  (origin (method url-fetch) (uri (crate-uri "ratatui-termwiz" "0.1.0"))
   (file-name "rust-ratatui-termwiz-0.1.0.tar.gz")
   (sha256 (base32 "0p2l7pymlcfv9n802pd32m604m145rrpc5hv6bq9ahpds05zwxhg"))))

(define rust-ratatui-widgets-0-3-0
  (origin (method url-fetch) (uri (crate-uri "ratatui-widgets" "0.3.0"))
   (file-name "rust-ratatui-widgets-0.3.0.tar.gz")
   (sha256 (base32 "1nqjcrskazvfgjkmmsifliqrvap8bw6850rlap109rnl7h1gmnyp"))))

(define rust-recvmsg-1-0-0
  (origin (method url-fetch) (uri (crate-uri "recvmsg" "1.0.0"))
   (file-name "rust-recvmsg-1.0.0.tar.gz")
   (sha256 (base32 "0xa173gbg1cx8q7wyzi6c4kmcsz5rka68r4jb6kg14icskax9vfk"))))

(define rust-redox_syscall-0-5-18
  (origin (method url-fetch) (uri (crate-uri "redox_syscall" "0.5.18"))
   (file-name "rust-redox_syscall-0.5.18.tar.gz")
   (sha256 (base32 "0b9n38zsxylql36vybw18if68yc9jczxmbyzdwyhb9sifmag4azd"))))

(define rust-ref-cast-1-0-25
  (origin (method url-fetch) (uri (crate-uri "ref-cast" "1.0.25"))
   (file-name "rust-ref-cast-1.0.25.tar.gz")
   (sha256 (base32 "0zdzc34qjva9xxgs889z5iz787g81hznk12zbk4g2xkgwq530m7k"))))

(define rust-ref-cast-impl-1-0-25
  (origin (method url-fetch) (uri (crate-uri "ref-cast-impl" "1.0.25"))
   (file-name "rust-ref-cast-impl-1.0.25.tar.gz")
   (sha256 (base32 "1nkhn1fklmn342z5c4mzfzlxddv3x8yhxwwk02cj06djvh36065p"))))

(define rust-regex-1-12-3
  (origin (method url-fetch) (uri (crate-uri "regex" "1.12.3"))
   (file-name "rust-regex-1.12.3.tar.gz")
   (sha256 (base32 "0xp2q0x7ybmpa5zlgaz00p8zswcirj9h8nry3rxxsdwi9fhm81z1"))))

(define rust-regex-automata-0-4-14
  (origin (method url-fetch) (uri (crate-uri "regex-automata" "0.4.14"))
   (file-name "rust-regex-automata-0.4.14.tar.gz")
   (sha256 (base32 "13xf7hhn4qmgfh784llcp2kzrvljd13lb2b1ca0mwnf15w9d87bf"))))

(define rust-regex-syntax-0-8-10
  (origin (method url-fetch) (uri (crate-uri "regex-syntax" "0.8.10"))
   (file-name "rust-regex-syntax-0.8.10.tar.gz")
   (sha256 (base32 "02jx311ka0daxxc7v45ikzhcl3iydjbbb0mdrpc1xgg8v7c7v2fw"))))

(define rust-rustc_version-0-4-1
  (origin (method url-fetch) (uri (crate-uri "rustc_version" "0.4.1"))
   (file-name "rust-rustc_version-0.4.1.tar.gz")
   (sha256 (base32 "14lvdsmr5si5qbqzrajgb6vfn69k0sfygrvfvr2mps26xwi3mjyg"))))

(define rust-rustix-1-1-4
  (origin (method url-fetch) (uri (crate-uri "rustix" "1.1.4"))
   (file-name "rust-rustix-1.1.4.tar.gz")
   (sha256 (base32 "14511f9yjqh0ix07xjrjpllah3325774gfwi9zpq72sip5jlbzmn"))))

(define rust-rustversion-1-0-22
  (origin (method url-fetch) (uri (crate-uri "rustversion" "1.0.22"))
   (file-name "rust-rustversion-1.0.22.tar.gz")
   (sha256 (base32 "0vfl70jhv72scd9rfqgr2n11m5i9l1acnk684m2w83w0zbqdx75k"))))

(define rust-ryu-1-0-23
  (origin (method url-fetch) (uri (crate-uri "ryu" "1.0.23"))
   (file-name "rust-ryu-1.0.23.tar.gz")
   (sha256 (base32 "0zs70sg00l2fb9jwrf6cbkdyscjs53anrvai2hf7npyyfi5blx4p"))))

(define rust-schemars-1-2-1
  (origin (method url-fetch) (uri (crate-uri "schemars" "1.2.1"))
   (file-name "rust-schemars-1.2.1.tar.gz")
   (sha256 (base32 "1k16qzpdpy6p9hrh18q2l6cwawxzyqi25f8masa13l0wm8v2zd52"))))

(define rust-schemars_derive-1-2-1
  (origin (method url-fetch) (uri (crate-uri "schemars_derive" "1.2.1"))
   (file-name "rust-schemars_derive-1.2.1.tar.gz")
   (sha256 (base32 "0zrh1ckcc63sqy5hyhnh2lbxh4vmbij2z4f1g5za1vmayi85n4bx"))))

(define rust-scopeguard-1-2-0
  (origin (method url-fetch) (uri (crate-uri "scopeguard" "1.2.0"))
   (file-name "rust-scopeguard-1.2.0.tar.gz")
   (sha256 (base32 "0jcz9sd47zlsgcnm1hdw0664krxwb5gczlif4qngj2aif8vky54l"))))

(define rust-semver-1-0-27
  (origin (method url-fetch) (uri (crate-uri "semver" "1.0.27"))
   (file-name "rust-semver-1.0.27.tar.gz")
   (sha256 (base32 "1qmi3akfrnqc2hfkdgcxhld5bv961wbk8my3ascv5068mc5fnryp"))))

(define rust-serde-1-0-228
  (origin (method url-fetch) (uri (crate-uri "serde" "1.0.228"))
   (file-name "rust-serde-1.0.228.tar.gz")
   (sha256 (base32 "17mf4hhjxv5m90g42wmlbc61hdhlm6j9hwfkpcnd72rpgzm993ls"))))

(define rust-serde_core-1-0-228
  (origin (method url-fetch) (uri (crate-uri "serde_core" "1.0.228"))
   (file-name "rust-serde_core-1.0.228.tar.gz")
   (sha256 (base32 "1bb7id2xwx8izq50098s5j2sqrrvk31jbbrjqygyan6ask3qbls1"))))

(define rust-serde_derive-1-0-228
  (origin (method url-fetch) (uri (crate-uri "serde_derive" "1.0.228"))
   (file-name "rust-serde_derive-1.0.228.tar.gz")
   (sha256 (base32 "0y8xm7fvmr2kjcd029g9fijpndh8csv5m20g4bd76w8qschg4h6m"))))

(define rust-serde_derive_internals-0-29-1
  (origin (method url-fetch) (uri (crate-uri "serde_derive_internals" "0.29.1"))
   (file-name "rust-serde_derive_internals-0.29.1.tar.gz")
   (sha256 (base32 "04g7macx819vbnxhi52cx0nhxi56xlhrybgwybyy7fb9m4h6mlhq"))))

(define rust-serde_json-1-0-149
  (origin (method url-fetch) (uri (crate-uri "serde_json" "1.0.149"))
   (file-name "rust-serde_json-1.0.149.tar.gz")
   (sha256 (base32 "11jdx4vilzrjjd1dpgy67x5lgzr0laplz30dhv75lnf5ffa07z43"))))

(define rust-serde_spanned-0-6-9
  (origin (method url-fetch) (uri (crate-uri "serde_spanned" "0.6.9"))
   (file-name "rust-serde_spanned-0.6.9.tar.gz")
   (sha256 (base32 "18vmxq6qfrm110caszxrzibjhy2s54n1g5w1bshxq9kjmz7y0hdz"))))

(define rust-serial2-0-2-34
  (origin (method url-fetch) (uri (crate-uri "serial2" "0.2.34"))
   (file-name "rust-serial2-0.2.34.tar.gz")
   (sha256 (base32 "0l0m4h0f8yfwpsczvl4bnqfxw7l7lx8nx57qppywsn6kcbsh254y"))))

(define rust-sha2-0-10-9
  (origin (method url-fetch) (uri (crate-uri "sha2" "0.10.9"))
   (file-name "rust-sha2-0.10.9.tar.gz")
   (sha256 (base32 "10xjj843v31ghsksd9sl9y12qfc48157j1xpb8v1ml39jy0psl57"))))

(define rust-sharded-slab-0-1-7
  (origin (method url-fetch) (uri (crate-uri "sharded-slab" "0.1.7"))
   (file-name "rust-sharded-slab-0.1.7.tar.gz")
   (sha256 (base32 "1xipjr4nqsgw34k7a2cgj9zaasl2ds6jwn89886kww93d32a637l"))))

(define rust-shared_library-0-1-9
  (origin (method url-fetch) (uri (crate-uri "shared_library" "0.1.9"))
   (file-name "rust-shared_library-0.1.9.tar.gz")
   (sha256 (base32 "04fs37kdak051hm524a360978g58ayrcarjsbf54vqps5c7px7js"))))

(define rust-shell-words-1-1-1
  (origin (method url-fetch) (uri (crate-uri "shell-words" "1.1.1"))
   (file-name "rust-shell-words-1.1.1.tar.gz")
   (sha256 (base32 "0xzd5p53xl0ndnk63r0by52rhdrh6pd37szfxszkg73zb6ffcvyw"))))

(define rust-signal-hook-0-3-18
  (origin (method url-fetch) (uri (crate-uri "signal-hook" "0.3.18"))
   (file-name "rust-signal-hook-0.3.18.tar.gz")
   (sha256 (base32 "1qnnbq4g2vixfmlv28i1whkr0hikrf1bsc4xjy2aasj2yina30fq"))))

(define rust-signal-hook-mio-0-2-5
  (origin (method url-fetch) (uri (crate-uri "signal-hook-mio" "0.2.5"))
   (file-name "rust-signal-hook-mio-0.2.5.tar.gz")
   (sha256 (base32 "1k20rr76ngvmzr6kskkl7dv8iyb84cbydpjbjk3mpcj0lykijnmp"))))

(define rust-signal-hook-registry-1-4-8
  (origin (method url-fetch) (uri (crate-uri "signal-hook-registry" "1.4.8"))
   (file-name "rust-signal-hook-registry-1.4.8.tar.gz")
   (sha256 (base32 "06vc7pmnki6lmxar3z31gkyg9cw7py5x9g7px70gy2hil75nkny4"))))

(define rust-simd-adler32-0-3-9
  (origin (method url-fetch) (uri (crate-uri "simd-adler32" "0.3.9"))
   (file-name "rust-simd-adler32-0.3.9.tar.gz")
   (sha256 (base32 "0532ysdwcvzyp2bwpk8qz0hijplcdwpssr5gy5r7qwqqy5z5qgbh"))))

(define rust-siphasher-1-0-2
  (origin (method url-fetch) (uri (crate-uri "siphasher" "1.0.2"))
   (file-name "rust-siphasher-1.0.2.tar.gz")
   (sha256 (base32 "13k7cfbpcm8qgj9p2n8dwg9skv9s0hxk5my30j5chy1p4l78bamj"))))

(define rust-smallvec-1-15-1
  (origin (method url-fetch) (uri (crate-uri "smallvec" "1.15.1"))
   (file-name "rust-smallvec-1.15.1.tar.gz")
   (sha256 (base32 "00xxdxxpgyq5vjnpljvkmy99xij5rxgh913ii1v16kzynnivgcb7"))))

(define rust-static_assertions-1-1-0
  (origin (method url-fetch) (uri (crate-uri "static_assertions" "1.1.0"))
   (file-name "rust-static_assertions-1.1.0.tar.gz")
   (sha256 (base32 "0gsl6xmw10gvn3zs1rv99laj5ig7ylffnh71f9l34js4nr4r7sx2"))))

(define rust-strsim-0-11-1
  (origin (method url-fetch) (uri (crate-uri "strsim" "0.11.1"))
   (file-name "rust-strsim-0.11.1.tar.gz")
   (sha256 (base32 "0kzvqlw8hxqb7y598w1s0hxlnmi84sg5vsipp3yg5na5d1rvba3x"))))

(define rust-strum-0-27-2
  (origin (method url-fetch) (uri (crate-uri "strum" "0.27.2"))
   (file-name "rust-strum-0.27.2.tar.gz")
   (sha256 (base32 "1ksb9jssw4bg9kmv9nlgp2jqa4vnsa3y4q9zkppvl952q7vdc8xg"))))

(define rust-strum_macros-0-27-2
  (origin (method url-fetch) (uri (crate-uri "strum_macros" "0.27.2"))
   (file-name "rust-strum_macros-0.27.2.tar.gz")
   (sha256 (base32 "19xwikxma0yi70fxkcy1yxcv0ica8gf3jnh5gj936jza8lwcx5bn"))))

(define rust-syn-1-0-109
  (origin (method url-fetch) (uri (crate-uri "syn" "1.0.109"))
   (file-name "rust-syn-1.0.109.tar.gz")
   (sha256 (base32 "0ds2if4600bd59wsv7jjgfkayfzy3hnazs394kz6zdkmna8l3dkj"))))

(define rust-syn-2-0-117
  (origin (method url-fetch) (uri (crate-uri "syn" "2.0.117"))
   (file-name "rust-syn-2.0.117.tar.gz")
   (sha256 (base32 "16cv7c0wbn8amxc54n4w15kxlx5ypdmla8s0gxr2l7bv7s0bhrg6"))))

(define rust-terminfo-0-9-0
  (origin (method url-fetch) (uri (crate-uri "terminfo" "0.9.0"))
   (file-name "rust-terminfo-0.9.0.tar.gz")
   (sha256 (base32 "0qp6rrzkxcg08vjzsim2bw7mid3vi29mizrg70dzbycj0q7q3snl"))))

(define rust-termios-0-3-3
  (origin (method url-fetch) (uri (crate-uri "termios" "0.3.3"))
   (file-name "rust-termios-0.3.3.tar.gz")
   (sha256 (base32 "0sxcs0g00538jqh5xbdqakkzijadr8nj7zmip0c7jz3k83vmn721"))))

(define rust-termwiz-0-23-3
  (origin (method url-fetch) (uri (crate-uri "termwiz" "0.23.3"))
   (file-name "rust-termwiz-0.23.3.tar.gz")
   (sha256 (base32 "1xzq6l7rx285ax57dz8gdh44kp1790x0knvfynmimgfc89rb6xj6"))))

(define rust-thiserror-1-0-69
  (origin (method url-fetch) (uri (crate-uri "thiserror" "1.0.69"))
   (file-name "rust-thiserror-1.0.69.tar.gz")
   (sha256 (base32 "0lizjay08agcr5hs9yfzzj6axs53a2rgx070a1dsi3jpkcrzbamn"))))

(define rust-thiserror-2-0-18
  (origin (method url-fetch) (uri (crate-uri "thiserror" "2.0.18"))
   (file-name "rust-thiserror-2.0.18.tar.gz")
   (sha256 (base32 "1i7vcmw9900bvsmay7mww04ahahab7wmr8s925xc083rpjybb222"))))

(define rust-thiserror-impl-1-0-69
  (origin (method url-fetch) (uri (crate-uri "thiserror-impl" "1.0.69"))
   (file-name "rust-thiserror-impl-1.0.69.tar.gz")
   (sha256 (base32 "1h84fmn2nai41cxbhk6pqf46bxqq1b344v8yz089w1chzi76rvjg"))))

(define rust-thiserror-impl-2-0-18
  (origin (method url-fetch) (uri (crate-uri "thiserror-impl" "2.0.18"))
   (file-name "rust-thiserror-impl-2.0.18.tar.gz")
   (sha256 (base32 "1mf1vrbbimj1g6dvhdgzjmn6q09yflz2b92zs1j9n3k7cxzyxi7b"))))

(define rust-thread_local-1-1-9
  (origin (method url-fetch) (uri (crate-uri "thread_local" "1.1.9"))
   (file-name "rust-thread_local-1.1.9.tar.gz")
   (sha256 (base32 "1191jvl8d63agnq06pcnarivf63qzgpws5xa33hgc92gjjj4c0pn"))))

(define rust-time-0-3-47
  (origin (method url-fetch) (uri (crate-uri "time" "0.3.47"))
   (file-name "rust-time-0.3.47.tar.gz")
   (sha256 (base32 "0b7g9ly2iabrlgizliz6v5x23yq5d6bpp0mqz6407z1s526d8fvl"))))

(define rust-time-core-0-1-8
  (origin (method url-fetch) (uri (crate-uri "time-core" "0.1.8"))
   (file-name "rust-time-core-0.1.8.tar.gz")
   (sha256 (base32 "1jidl426mw48i7hjj4hs9vxgd9lwqq4vyalm4q8d7y4iwz7y353n"))))

(define rust-tokio-1-50-0
  (origin (method url-fetch) (uri (crate-uri "tokio" "1.50.0"))
   (file-name "rust-tokio-1.50.0.tar.gz")
   (sha256 (base32 "0bc2c5kd57p2xd4l6hagb0bkrp798k5vw0f3xzzwy0sf6ws5xb97"))))

(define rust-tokio-macros-2-6-1
  (origin (method url-fetch) (uri (crate-uri "tokio-macros" "2.6.1"))
   (file-name "rust-tokio-macros-2.6.1.tar.gz")
   (sha256 (base32 "172nwz3s7mmh266hb8l5xdnc7v9kqahisppqhinfd75nz3ps4maw"))))

(define rust-toml-0-8-23
  (origin (method url-fetch) (uri (crate-uri "toml" "0.8.23"))
   (file-name "rust-toml-0.8.23.tar.gz")
   (sha256 (base32 "0qnkrq4lm2sdhp3l6cb6f26i8zbnhqb7mhbmksd550wxdfcyn6yw"))))

(define rust-toml_datetime-0-6-11
  (origin (method url-fetch) (uri (crate-uri "toml_datetime" "0.6.11"))
   (file-name "rust-toml_datetime-0.6.11.tar.gz")
   (sha256 (base32 "077ix2hb1dcya49hmi1avalwbixmrs75zgzb3b2i7g2gizwdmk92"))))

(define rust-toml_edit-0-22-27
  (origin (method url-fetch) (uri (crate-uri "toml_edit" "0.22.27"))
   (file-name "rust-toml_edit-0.22.27.tar.gz")
   (sha256 (base32 "16l15xm40404asih8vyjvnka9g0xs9i4hfb6ry3ph9g419k8rzj1"))))

(define rust-toml_write-0-1-2
  (origin (method url-fetch) (uri (crate-uri "toml_write" "0.1.2"))
   (file-name "rust-toml_write-0.1.2.tar.gz")
   (sha256 (base32 "008qlhqlqvljp1gpp9rn5cqs74gwvdgbvs92wnpq8y3jlz4zi6ax"))))

(define rust-tracing-0-1-44
  (origin (method url-fetch) (uri (crate-uri "tracing" "0.1.44"))
   (file-name "rust-tracing-0.1.44.tar.gz")
   (sha256 (base32 "006ilqkg1lmfdh3xhg3z762izfwmxcvz0w7m4qx2qajbz9i1drv3"))))

(define rust-tracing-attributes-0-1-31
  (origin (method url-fetch) (uri (crate-uri "tracing-attributes" "0.1.31"))
   (file-name "rust-tracing-attributes-0.1.31.tar.gz")
   (sha256 (base32 "1np8d77shfvz0n7camx2bsf1qw0zg331lra0hxb4cdwnxjjwz43l"))))

(define rust-tracing-core-0-1-36
  (origin (method url-fetch) (uri (crate-uri "tracing-core" "0.1.36"))
   (file-name "rust-tracing-core-0.1.36.tar.gz")
   (sha256 (base32 "16mpbz6p8vd6j7sf925k9k8wzvm9vdfsjbynbmaxxyq6v7wwm5yv"))))

(define rust-tracing-log-0-2-0
  (origin (method url-fetch) (uri (crate-uri "tracing-log" "0.2.0"))
   (file-name "rust-tracing-log-0.2.0.tar.gz")
   (sha256 (base32 "1hs77z026k730ij1a9dhahzrl0s073gfa2hm5p0fbl0b80gmz1gf"))))

(define rust-tracing-subscriber-0-3-23
  (origin (method url-fetch) (uri (crate-uri "tracing-subscriber" "0.3.23"))
   (file-name "rust-tracing-subscriber-0.3.23.tar.gz")
   (sha256 (base32 "06fkr0qhggvrs861d7f74pn3i3a10h5jsp4n70jj9ys5b675fzyb"))))

(define rust-typenum-1-19-0
  (origin (method url-fetch) (uri (crate-uri "typenum" "1.19.0"))
   (file-name "rust-typenum-1.19.0.tar.gz")
   (sha256 (base32 "1fw2mpbn2vmqan56j1b3fbpcdg80mz26fm53fs16bq5xcq84hban"))))

(define rust-ucd-trie-0-1-7
  (origin (method url-fetch) (uri (crate-uri "ucd-trie" "0.1.7"))
   (file-name "rust-ucd-trie-0.1.7.tar.gz")
   (sha256 (base32 "0wc9p07sqwz320848i52nvyjvpsxkx3kv5bfbmm6s35809fdk5i8"))))

(define rust-unicode-ident-1-0-24
  (origin (method url-fetch) (uri (crate-uri "unicode-ident" "1.0.24"))
   (file-name "rust-unicode-ident-1.0.24.tar.gz")
   (sha256 (base32 "0xfs8y1g7syl2iykji8zk5hgfi5jw819f5zsrbaxmlzwsly33r76"))))

(define rust-unicode-segmentation-1-13-1
  (origin (method url-fetch) (uri (crate-uri "unicode-segmentation" "1.13.1"))
   (file-name "rust-unicode-segmentation-1.13.1.tar.gz")
   (sha256 (base32 "0nq2v5daqvzpxfgz1lm2g23jkj4j6f03j1zyzz6br12lh2d0hdns"))))

(define rust-unicode-truncate-2-0-1
  (origin (method url-fetch) (uri (crate-uri "unicode-truncate" "2.0.1"))
   (file-name "rust-unicode-truncate-2.0.1.tar.gz")
   (sha256 (base32 "19g9af5v0a8xaigqbs9hi9csxkg1fff07ycilvwfaqw64fhq1cqn"))))

(define rust-unicode-width-0-2-2
  (origin (method url-fetch) (uri (crate-uri "unicode-width" "0.2.2"))
   (file-name "rust-unicode-width-0.2.2.tar.gz")
   (sha256 (base32 "0m7jjzlcccw716dy9423xxh0clys8pfpllc5smvfxrzdf66h9b5l"))))

(define rust-unicode-xid-0-2-6
  (origin (method url-fetch) (uri (crate-uri "unicode-xid" "0.2.6"))
   (file-name "rust-unicode-xid-0.2.6.tar.gz")
   (sha256 (base32 "0lzqaky89fq0bcrh6jj6bhlz37scfd8c7dsj5dq7y32if56c1hgb"))))

(define rust-unty-0-0-4
  (origin (method url-fetch) (uri (crate-uri "unty" "0.0.4"))
   (file-name "rust-unty-0.0.4.tar.gz")
   (sha256 (base32 "1blhyv01qiv5sb72sal3xa1l8nzck3answawxkkiw3fd2x1phjbd"))))

(define rust-utf8parse-0-2-2
  (origin (method url-fetch) (uri (crate-uri "utf8parse" "0.2.2"))
   (file-name "rust-utf8parse-0.2.2.tar.gz")
   (sha256 (base32 "088807qwjq46azicqwbhlmzwrbkz7l4hpw43sdkdyyk524vdxaq6"))))

(define rust-uuid-1-22-0
  (origin (method url-fetch) (uri (crate-uri "uuid" "1.22.0"))
   (file-name "rust-uuid-1.22.0.tar.gz")
   (sha256 (base32 "0dvsfn44sddhyhlhk7m3i559wyb125h86799fm5abky0067kr3d6"))))

(define rust-valuable-0-1-1
  (origin (method url-fetch) (uri (crate-uri "valuable" "0.1.1"))
   (file-name "rust-valuable-0.1.1.tar.gz")
   (sha256 (base32 "0r9srp55v7g27s5bg7a2m095fzckrcdca5maih6dy9bay6fflwxs"))))

(define rust-version_check-0-9-5
  (origin (method url-fetch) (uri (crate-uri "version_check" "0.9.5"))
   (file-name "rust-version_check-0.9.5.tar.gz")
   (sha256 (base32 "0nhhi4i5x89gm911azqbn7avs9mdacw2i3vcz3cnmz3mv4rqz4hb"))))

(define rust-virtue-0-0-18
  (origin (method url-fetch) (uri (crate-uri "virtue" "0.0.18"))
   (file-name "rust-virtue-0.0.18.tar.gz")
   (sha256 (base32 "1cgp79pzzs117kjlc3jnnkixbyaqri12j40mx2an41qhrymv27h5"))))

(define rust-vtparse-0-6-2
  (origin (method url-fetch) (uri (crate-uri "vtparse" "0.6.2"))
   (file-name "rust-vtparse-0.6.2.tar.gz")
   (sha256 (base32 "1l5yz9650zhkaffxn28cvfys7plcw2wd6drajyf41pshn37jm6vd"))))

(define rust-wasi-0-11-1pluswasi-snapshot-preview1
  (origin (method url-fetch) (uri (crate-uri "wasi" "0.11.1+wasi-snapshot-preview1"))
   (file-name "rust-wasi-0.11.1+wasi-snapshot-preview1.tar.gz")
   (sha256 (base32 "0jx49r7nbkbhyfrfyhz0bm4817yrnxgd3jiwwwfv0zl439jyrwyc"))))

(define rust-wasip2-1-0-2pluswasi-0-2-9
  (origin (method url-fetch) (uri (crate-uri "wasip2" "1.0.2+wasi-0.2.9"))
   (file-name "rust-wasip2-1.0.2+wasi-0.2.9.tar.gz")
   (sha256 (base32 "1xdw7v08jpfjdg94sp4lbdgzwa587m5ifpz6fpdnkh02kwizj5wm"))))

(define rust-wasip3-0-4-0pluswasi-0-3-0-rc-2026-01-06
  (origin (method url-fetch) (uri (crate-uri "wasip3" "0.4.0+wasi-0.3.0-rc-2026-01-06"))
   (file-name "rust-wasip3-0.4.0+wasi-0.3.0-rc-2026-01-06.tar.gz")
   (sha256 (base32 "19dc8p0y2mfrvgk3qw3c3240nfbylv22mvyxz84dqpgai2zzha2l"))))

(define rust-wasm-bindgen-0-2-114
  (origin (method url-fetch) (uri (crate-uri "wasm-bindgen" "0.2.114"))
   (file-name "rust-wasm-bindgen-0.2.114.tar.gz")
   (sha256 (base32 "13nkhw552hpllrrmkd2x9y4bmcxr82kdpky2n667kqzcq6jzjck5"))))

(define rust-wasm-bindgen-macro-0-2-114
  (origin (method url-fetch) (uri (crate-uri "wasm-bindgen-macro" "0.2.114"))
   (file-name "rust-wasm-bindgen-macro-0.2.114.tar.gz")
   (sha256 (base32 "1rhq9kkl7n0zjrag9p25xsi4aabpgfkyf02zn4xv6pqhrw7xb8hq"))))

(define rust-wasm-bindgen-macro-support-0-2-114
  (origin (method url-fetch) (uri (crate-uri "wasm-bindgen-macro-support" "0.2.114"))
   (file-name "rust-wasm-bindgen-macro-support-0.2.114.tar.gz")
   (sha256 (base32 "1qriqqjpn922kv5c7f7627fj823k5aifv06j2gvwsiy5map4rkh3"))))

(define rust-wasm-bindgen-shared-0-2-114
  (origin (method url-fetch) (uri (crate-uri "wasm-bindgen-shared" "0.2.114"))
   (file-name "rust-wasm-bindgen-shared-0.2.114.tar.gz")
   (sha256 (base32 "05lc6w64jxlk4wk8rjci4z61lhx2ams90la27a41gvi3qaw2d8vm"))))

(define rust-wasm-encoder-0-244-0
  (origin (method url-fetch) (uri (crate-uri "wasm-encoder" "0.244.0"))
   (file-name "rust-wasm-encoder-0.244.0.tar.gz")
   (sha256 (base32 "06c35kv4h42vk3k51xjz1x6hn3mqwfswycmr6ziky033zvr6a04r"))))

(define rust-wasm-metadata-0-244-0
  (origin (method url-fetch) (uri (crate-uri "wasm-metadata" "0.244.0"))
   (file-name "rust-wasm-metadata-0.244.0.tar.gz")
   (sha256 (base32 "02f9dhlnryd2l7zf03whlxai5sv26x4spfibjdvc3g9gd8z3a3mv"))))

(define rust-wasmparser-0-244-0
  (origin (method url-fetch) (uri (crate-uri "wasmparser" "0.244.0"))
   (file-name "rust-wasmparser-0.244.0.tar.gz")
   (sha256 (base32 "1zi821hrlsxfhn39nqpmgzc0wk7ax3dv6vrs5cw6kb0v5v3hgf27"))))

(define rust-wezterm-bidi-0-2-3
  (origin (method url-fetch) (uri (crate-uri "wezterm-bidi" "0.2.3"))
   (file-name "rust-wezterm-bidi-0.2.3.tar.gz")
   (sha256 (base32 "1v7kwmnxfplv9kgdmamn6csbn2ag5xjr0y6gs797slk0alsnw2hc"))))

(define rust-wezterm-blob-leases-0-1-1
  (origin (method url-fetch) (uri (crate-uri "wezterm-blob-leases" "0.1.1"))
   (file-name "rust-wezterm-blob-leases-0.1.1.tar.gz")
   (sha256 (base32 "1dwf8bm3cwdi37fandwbk7nsfhn9spv4wm0l86gf551xv7vaybb9"))))

(define rust-wezterm-color-types-0-3-0
  (origin (method url-fetch) (uri (crate-uri "wezterm-color-types" "0.3.0"))
   (file-name "rust-wezterm-color-types-0.3.0.tar.gz")
   (sha256 (base32 "15j29f60p1dc0msx50x940niyv9d5zpynavpcc6jf44hbkrixs3x"))))

(define rust-wezterm-dynamic-0-2-1
  (origin (method url-fetch) (uri (crate-uri "wezterm-dynamic" "0.2.1"))
   (file-name "rust-wezterm-dynamic-0.2.1.tar.gz")
   (sha256 (base32 "1b6mrk09xxiz66dj3912kmiq8rl7dqig6rwminkfmmhg287bcajz"))))

(define rust-wezterm-dynamic-derive-0-1-1
  (origin (method url-fetch) (uri (crate-uri "wezterm-dynamic-derive" "0.1.1"))
   (file-name "rust-wezterm-dynamic-derive-0.1.1.tar.gz")
   (sha256 (base32 "0nspip7gwzmfn66fbnbpa2yik2sb97nckzmgir25nr4wacnwzh26"))))

(define rust-wezterm-input-types-0-1-0
  (origin (method url-fetch) (uri (crate-uri "wezterm-input-types" "0.1.0"))
   (file-name "rust-wezterm-input-types-0.1.0.tar.gz")
   (sha256 (base32 "0zp557014d458a69yqn9dxfy270b6kyfdiynr5p4algrb7aas4kh"))))

(define rust-widestring-1-2-1
  (origin (method url-fetch) (uri (crate-uri "widestring" "1.2.1"))
   (file-name "rust-widestring-1.2.1.tar.gz")
   (sha256 (base32 "0wg4qdbs70xqnlbm8wb0bs4idm2mxk3b6kaqwllsncmb2cqrq1kj"))))

(define rust-winapi-0-3-9
  (origin (method url-fetch) (uri (crate-uri "winapi" "0.3.9"))
   (file-name "rust-winapi-0.3.9.tar.gz")
   (sha256 (base32 "06gl025x418lchw1wxj64ycr7gha83m44cjr5sarhynd9xkrm0sw"))))

(define rust-winapi-i686-pc-windows-gnu-0-4-0
  (origin (method url-fetch) (uri (crate-uri "winapi-i686-pc-windows-gnu" "0.4.0"))
   (file-name "rust-winapi-i686-pc-windows-gnu-0.4.0.tar.gz")
   (sha256 (base32 "1dmpa6mvcvzz16zg6d5vrfy4bxgg541wxrcip7cnshi06v38ffxc"))))

(define rust-winapi-x86_64-pc-windows-gnu-0-4-0
  (origin (method url-fetch) (uri (crate-uri "winapi-x86_64-pc-windows-gnu" "0.4.0"))
   (file-name "rust-winapi-x86_64-pc-windows-gnu-0.4.0.tar.gz")
   (sha256 (base32 "0gqq64czqb64kskjryj8isp62m2sgvx25yyj3kpc2myh85w24bki"))))

(define rust-windows-link-0-2-1
  (origin (method url-fetch) (uri (crate-uri "windows-link" "0.2.1"))
   (file-name "rust-windows-link-0.2.1.tar.gz")
   (sha256 (base32 "1rag186yfr3xx7piv5rg8b6im2dwcf8zldiflvb22xbzwli5507h"))))

(define rust-windows-sys-0-61-2
  (origin (method url-fetch) (uri (crate-uri "windows-sys" "0.61.2"))
   (file-name "rust-windows-sys-0.61.2.tar.gz")
   (sha256 (base32 "1z7k3y9b6b5h52kid57lvmvm05362zv1v8w0gc7xyv5xphlp44xf"))))

(define rust-winnow-0-7-15
  (origin (method url-fetch) (uri (crate-uri "winnow" "0.7.15"))
   (file-name "rust-winnow-0.7.15.tar.gz")
   (sha256 (base32 "0i9rkl2rqpbnnxlgs20gmkj3nd0b2k8q55mjmpc2ybb84xwxjyfz"))))

(define rust-winreg-0-10-1
  (origin (method url-fetch) (uri (crate-uri "winreg" "0.10.1"))
   (file-name "rust-winreg-0.10.1.tar.gz")
   (sha256 (base32 "17c6h02z88ijjba02bnxi5k94q5cz490nf3njh9yypf8fbig9l40"))))

(define rust-wit-bindgen-0-51-0
  (origin (method url-fetch) (uri (crate-uri "wit-bindgen" "0.51.0"))
   (file-name "rust-wit-bindgen-0.51.0.tar.gz")
   (sha256 (base32 "19fazgch8sq5cvjv3ynhhfh5d5x08jq2pkw8jfb05vbcyqcr496p"))))

(define rust-wit-bindgen-core-0-51-0
  (origin (method url-fetch) (uri (crate-uri "wit-bindgen-core" "0.51.0"))
   (file-name "rust-wit-bindgen-core-0.51.0.tar.gz")
   (sha256 (base32 "1p2jszqsqbx8k7y8nwvxg65wqzxjm048ba5phaq8r9iy9ildwqga"))))

(define rust-wit-bindgen-rust-0-51-0
  (origin (method url-fetch) (uri (crate-uri "wit-bindgen-rust" "0.51.0"))
   (file-name "rust-wit-bindgen-rust-0.51.0.tar.gz")
   (sha256 (base32 "08bzn5fsvkb9x9wyvyx98qglknj2075xk1n7c5jxv15jykh6didp"))))

(define rust-wit-bindgen-rust-macro-0-51-0
  (origin (method url-fetch) (uri (crate-uri "wit-bindgen-rust-macro" "0.51.0"))
   (file-name "rust-wit-bindgen-rust-macro-0.51.0.tar.gz")
   (sha256 (base32 "0ymizapzv2id89igxsz2n587y2hlfypf6n8kyp68x976fzyrn3qc"))))

(define rust-wit-component-0-244-0
  (origin (method url-fetch) (uri (crate-uri "wit-component" "0.244.0"))
   (file-name "rust-wit-component-0.244.0.tar.gz")
   (sha256 (base32 "1clwxgsgdns3zj2fqnrjcp8y5gazwfa1k0sy5cbk0fsmx4hflrlx"))))

(define rust-wit-parser-0-244-0
  (origin (method url-fetch) (uri (crate-uri "wit-parser" "0.244.0"))
   (file-name "rust-wit-parser-0.244.0.tar.gz")
   (sha256 (base32 "0dm7avvdxryxd5b02l0g5h6933z1cw5z0d4wynvq2cywq55srj7c"))))

(define rust-zmij-1-0-21
  (origin (method url-fetch) (uri (crate-uri "zmij" "1.0.21"))
   (file-name "rust-zmij-1.0.21.tar.gz")
   (sha256 (base32 "1amb5i6gz7yjb0dnmz5y669674pqmwbj44p4yfxfv2ncgvk8x15q"))))


;; ---------------------------------------------------------------------------
;; herdr
;; ---------------------------------------------------------------------------

(define-public herdr
  (package
    (name "herdr")
    (version "0.7.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ogulcancelik/herdr")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0pydrwk02shkr57rd76q5ayik48cb8hjqg2sgn0jkfa3xm8fqsgx"))))
    (build-system cargo-build-system)
    (arguments
     (list
      #:install-source? #f
      #:tests? #f
      #:phases
      #~(modify-phases %standard-phases
          (add-before 'configure 'setup-zig
            (lambda* (#:key inputs #:allow-other-keys)
              (setenv "ZIG" (string-append (assoc-ref inputs "zig") "/bin/zig"))
              (setenv "LIBGHOSTTY_VT_ZIG_SYSTEM_DIR"
                      (assoc-ref inputs "zig-ghostty-vt-system-dir"))
              (setenv "ZIG_GLOBAL_CACHE_DIR" "/tmp/zig-global-cache")
              (setenv "ZIG_LOCAL_CACHE_DIR" "/tmp/zig-local-cache")))
          (add-before 'configure 'set-version-string
            (lambda _ (setenv "HERDR_BUILD_CHANNEL" "guix")))
          )))
    (native-inputs
     `(("zig" ,zig-0.15)
       ("zig-ghostty-vt-system-dir" ,zig-ghostty-vt-system-dir)))
    (inputs
     (list
      rust-adler2-2-0-1
      rust-aho-corasick-1-1-4
      rust-allocator-api2-0-2-21
      rust-anstyle-1-0-14
      rust-anyhow-1-0-102
      rust-atomic-0-6-1
      rust-autocfg-1-5-0
      rust-base64-0-22-1
      rust-bincode-2-0-1
      rust-bincode_derive-2-0-1
      rust-bit-set-0-5-3
      rust-bit-vec-0-6-3
      rust-bitflags-1-3-2
      rust-bitflags-2-11-0
      rust-block-buffer-0-10-4
      rust-block2-0-6-2
      rust-bumpalo-3-20-2
      rust-bytemuck-1-25-0
      rust-bytes-1-11-1
      rust-castaway-0-2-4
      rust-cfg-if-1-0-4
      rust-cfg_aliases-0-1-1
      rust-cfg_aliases-0-2-1
      rust-clap-4-6-1
      rust-clap_builder-4-6-0
      rust-clap_complete-4-6-5
      rust-clap_lex-1-1-0
      rust-compact_str-0-9-0
      rust-convert_case-0-10-0
      rust-cpufeatures-0-2-17
      rust-crc32fast-1-5-0
      rust-crossterm-0-29-0
      rust-crossterm_winapi-0-9-1
      rust-crypto-common-0-1-7
      rust-csscolorparser-0-6-2
      rust-ctrlc-3-5-2
      rust-darling-0-23-0
      rust-darling_core-0-23-0
      rust-darling_macro-0-23-0
      rust-deltae-0-3-2
      rust-deranged-0-5-8
      rust-derive_more-2-1-1
      rust-derive_more-impl-2-1-1
      rust-digest-0-10-7
      rust-dispatch2-0-3-1
      rust-doctest-file-1-1-1
      rust-document-features-0-2-12
      rust-downcast-rs-1-2-1
      rust-dyn-clone-1-0-20
      rust-either-1-15-0
      rust-equivalent-1-0-2
      rust-errno-0-3-14
      rust-euclid-0-22-14
      rust-fancy-regex-0-11-0
      rust-fdeflate-0-3-7
      rust-filedescriptor-0-8-3
      rust-finl_unicode-1-4-0
      rust-fixedbitset-0-4-2
      rust-flate2-1-1-9
      rust-fnv-1-0-7
      rust-foldhash-0-1-5
      rust-foldhash-0-2-0
      rust-generic-array-0-14-7
      rust-getrandom-0-3-4
      rust-getrandom-0-4-2
      rust-hashbrown-0-15-5
      rust-hashbrown-0-16-1
      rust-heck-0-5-0
      rust-hex-0-4-3
      rust-id-arena-2-3-0
      rust-ident_case-1-0-1
      rust-indexmap-2-13-0
      rust-indoc-2-0-7
      rust-instability-0-3-12
      rust-interprocess-2-4-2
      rust-itertools-0-14-0
      rust-itoa-1-0-18
      rust-js-sys-0-3-91
      rust-kasuari-0-4-12
      rust-lab-0-11-0
      rust-lazy_static-1-5-0
      rust-leb128fmt-0-1-0
      rust-libc-0-2-183
      rust-line-clipping-0-3-5
      rust-linux-raw-sys-0-12-1
      rust-litrs-1-0-0
      rust-lock_api-0-4-14
      rust-log-0-4-29
      rust-lru-0-16-3
      rust-mac_address-1-1-8
      rust-matchers-0-2-0
      rust-memchr-2-8-0
      rust-memmem-0-1-1
      rust-memoffset-0-9-1
      rust-minimal-lexical-0-2-1
      rust-miniz_oxide-0-8-9
      rust-mio-1-1-1
      rust-nix-0-28-0
      rust-nix-0-29-0
      rust-nix-0-31-2
      rust-nom-7-1-3
      rust-nu-ansi-term-0-50-3
      rust-num-conv-0-2-1
      rust-num-derive-0-4-2
      rust-num-traits-0-2-19
      rust-num_threads-0-1-7
      rust-objc2-0-6-4
      rust-objc2-encode-4-1-0
      rust-once_cell-1-21-4
      rust-ordered-float-4-6-0
      rust-parking_lot-0-12-5
      rust-parking_lot_core-0-9-12
      rust-pest-2-8-6
      rust-pest_derive-2-8-6
      rust-pest_generator-2-8-6
      rust-pest_meta-2-8-6
      rust-phf-0-11-3
      rust-phf_codegen-0-11-3
      rust-phf_generator-0-11-3
      rust-phf_macros-0-11-3
      rust-phf_shared-0-11-3
      rust-pin-project-lite-0-2-17
      rust-png-0-17-16
      rust-portable-atomic-1-13-1
      rust-powerfmt-0-2-0
      rust-prettyplease-0-2-37
      rust-proc-macro2-1-0-106
      rust-quote-1-0-45
      rust-r-efi-5-3-0
      rust-r-efi-6-0-0
      rust-rand-0-8-5
      rust-rand_core-0-6-4
      rust-ratatui-0-30-0
      rust-ratatui-core-0-1-0
      rust-ratatui-crossterm-0-1-0
      rust-ratatui-macros-0-7-0
      rust-ratatui-termwiz-0-1-0
      rust-ratatui-widgets-0-3-0
      rust-recvmsg-1-0-0
      rust-redox_syscall-0-5-18
      rust-ref-cast-1-0-25
      rust-ref-cast-impl-1-0-25
      rust-regex-1-12-3
      rust-regex-automata-0-4-14
      rust-regex-syntax-0-8-10
      rust-rustc_version-0-4-1
      rust-rustix-1-1-4
      rust-rustversion-1-0-22
      rust-ryu-1-0-23
      rust-schemars-1-2-1
      rust-schemars_derive-1-2-1
      rust-scopeguard-1-2-0
      rust-semver-1-0-27
      rust-serde-1-0-228
      rust-serde_core-1-0-228
      rust-serde_derive-1-0-228
      rust-serde_derive_internals-0-29-1
      rust-serde_json-1-0-149
      rust-serde_spanned-0-6-9
      rust-serial2-0-2-34
      rust-sha2-0-10-9
      rust-sharded-slab-0-1-7
      rust-shared_library-0-1-9
      rust-shell-words-1-1-1
      rust-signal-hook-0-3-18
      rust-signal-hook-mio-0-2-5
      rust-signal-hook-registry-1-4-8
      rust-simd-adler32-0-3-9
      rust-siphasher-1-0-2
      rust-smallvec-1-15-1
      rust-static_assertions-1-1-0
      rust-strsim-0-11-1
      rust-strum-0-27-2
      rust-strum_macros-0-27-2
      rust-syn-1-0-109
      rust-syn-2-0-117
      rust-terminfo-0-9-0
      rust-termios-0-3-3
      rust-termwiz-0-23-3
      rust-thiserror-1-0-69
      rust-thiserror-2-0-18
      rust-thiserror-impl-1-0-69
      rust-thiserror-impl-2-0-18
      rust-thread_local-1-1-9
      rust-time-0-3-47
      rust-time-core-0-1-8
      rust-tokio-1-50-0
      rust-tokio-macros-2-6-1
      rust-toml-0-8-23
      rust-toml_datetime-0-6-11
      rust-toml_edit-0-22-27
      rust-toml_write-0-1-2
      rust-tracing-0-1-44
      rust-tracing-attributes-0-1-31
      rust-tracing-core-0-1-36
      rust-tracing-log-0-2-0
      rust-tracing-subscriber-0-3-23
      rust-typenum-1-19-0
      rust-ucd-trie-0-1-7
      rust-unicode-ident-1-0-24
      rust-unicode-segmentation-1-13-1
      rust-unicode-truncate-2-0-1
      rust-unicode-width-0-2-2
      rust-unicode-xid-0-2-6
      rust-unty-0-0-4
      rust-utf8parse-0-2-2
      rust-uuid-1-22-0
      rust-valuable-0-1-1
      rust-version_check-0-9-5
      rust-virtue-0-0-18
      rust-vtparse-0-6-2
      rust-wasi-0-11-1pluswasi-snapshot-preview1
      rust-wasip2-1-0-2pluswasi-0-2-9
      rust-wasip3-0-4-0pluswasi-0-3-0-rc-2026-01-06
      rust-wasm-bindgen-0-2-114
      rust-wasm-bindgen-macro-0-2-114
      rust-wasm-bindgen-macro-support-0-2-114
      rust-wasm-bindgen-shared-0-2-114
      rust-wasm-encoder-0-244-0
      rust-wasm-metadata-0-244-0
      rust-wasmparser-0-244-0
      rust-wezterm-bidi-0-2-3
      rust-wezterm-blob-leases-0-1-1
      rust-wezterm-color-types-0-3-0
      rust-wezterm-dynamic-0-2-1
      rust-wezterm-dynamic-derive-0-1-1
      rust-wezterm-input-types-0-1-0
      rust-widestring-1-2-1
      rust-winapi-0-3-9
      rust-winapi-i686-pc-windows-gnu-0-4-0
      rust-winapi-x86_64-pc-windows-gnu-0-4-0
      rust-windows-link-0-2-1
      rust-windows-sys-0-61-2
      rust-winnow-0-7-15
      rust-winreg-0-10-1
      rust-wit-bindgen-0-51-0
      rust-wit-bindgen-core-0-51-0
      rust-wit-bindgen-rust-0-51-0
      rust-wit-bindgen-rust-macro-0-51-0
      rust-wit-component-0-244-0
      rust-wit-parser-0-244-0
      rust-zmij-1-0-21
      ))
    (home-page "https://herdr.dev")
    (synopsis "Terminal workspace manager for AI coding agents")
    (description
     "Herdr is a terminal multiplexer built for AI coding agents.
It shows agent state (blocked, working, done, idle) at a glance,
with real PTYs per pane, persistent background server with detach/reattach,
workspaces and tabs, and a local socket API.")
    (license license:agpl3+)))
herdr
