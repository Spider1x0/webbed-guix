# Tuta Mail — Guix packaging design

Date: 2026-08-05
Channel: `~/webbed-guide` (note: not a git repo — spec saved, not committed)
Status: approved design, pending implementation plan

## Goal

Provide the Tuta (formerly Tutanota) desktop email client on Guix System,
delivered in maturity stages. No Guix package exists upstream or in any
third-party channel (verified 2026-08-05).

## Maturity stages

- **Stage 0 — Flatpak (zero effort, available now):** document
  `flatpak install flathub com.tutanota.Tutanota`. No `.scm` work.
- **Stage 1 — prebuilt-binary wrapper (this project):** a `nonguix`-style
  `-bin` package that unpacks the official AppImage and wraps the bundled
  Electron against Guix libraries.
- **Stage 2 - Future — build from source (higher maturity):** compile `tutao/tutanota`
  (npm dep tree + emscripten WASM Kyber crypto) against Guix `electron`.
  Documented as future work only; NOT in scope now.

## Upstream artifact (Stage 1)

- Release track tag: `tutanota-desktop-release-<version>` on GitHub
  `tutao/tutanota`. Latest at design time: `355.260720.0`.
- Asset: `tutanota-desktop-linux.AppImage` — filename is **unversioned**;
  the version lives only in the release-tag URL path. So a version bump
  touches the tag string + the source hash only.
- `./tutanota-desktop-linux.AppImage --appimage-extract` unpacks the
  squashfs without FUSE → build-sandbox friendly.
- Some releases also ship `*-unpacked-linux.tar.gz` (raw electron-builder
  tree) but it is not present on every release; AppImage is the reliable
  universal asset.

## Architecture (Stage 1)

Package `tuta` in `~/webbed-guide/packages/tuta.scm`, `trivial-build-system`
(no compilation), keeping the vendored Electron for native-module ABI safety:

1. **extract** — `AppImage --appimage-extract` → `squashfs-root/`
2. **install** — copy `squashfs-root/*` → `<out>/share/tuta/`
3. **patchelf** — `--set-interpreter` (glibc ld-linux) and `--set-rpath`
   on the bundled `electron`/`tutanota-desktop` ELF binary and any bundled
   `.so` it loads.
4. **wrap** — `<out>/bin/tuta` launcher execs the vendored electron;
   `wrap-program` sets `LD_LIBRARY_PATH` (runtime lib closure) and `PATH`.
5. **desktop integration** — install `.desktop` file and icons taken from
   the extracted tree into `<out>/share/applications` and
   `<out>/share/icons`.

Rationale for keeping bundled Electron: Guix has no Nix-style transitive
runtime propagation (same lesson as the caelestia qtwayland fix), and
native modules (better-sqlite3, keytar) must match the Electron ABI they
were built against.

## Runtime library closure (RPATH + LD_LIBRARY_PATH)

All Guix inputs, explicit (nothing auto-propagates on Guix):

`glibc`, `gcc:lib` (libstdc++), `nss`, `nspr`, `at-spi2-core`, `atk`,
`cairo`, `cups`, `dbus`, `expat`, `gdk-pixbuf`, `glib`, `gtk+` (gtk3),
`pango`, `mesa` (libgbm/GL), `libx11`, `libxcb`, `libxcomposite`,
`libxdamage`, `libxext`, `libxfixes`, `libxrandr`, `libxkbcommon`,
`libxshmfence`, `alsa-lib`, `libdrm`, `libsecret` (keyring/keytar),
`libnotify`, `libpng`, `fontconfig`, `freetype`.

Extend iteratively: `guix build` then run the binary and add any lib named
in an `error while loading shared libraries` / `cannot open shared object`
message. `ldd` on the bundled electron after patchelf reveals remaining
`not found` entries.

## Maintenance

- **Version bump:** update the release-tag string in the source URL, then
  `guix download <AppImage-url>` → new base32 hash. Documented in a header
  comment mirroring the `caelestia-shell.scm` source-pin convention.
- Prebuilt binary is not bit-reproducible; hash bump required per release.

## Testing / done criteria

- `guix build -L ~/webbed-guide tuta` succeeds.
- `$(guix build ...)/bin/tuta` opens the app window with no
  `error while loading shared libraries`.
- Login works (exercises network + nss TLS + libsecret keyring).
- `.desktop` entry and icon appear when the package is in a profile.

## Out of scope

- Source build (future stage).
- Auto-update mechanism (Guix manages updates via channel).
- Signature verification of the AppImage (Guix content-hash pins integrity).

## Implementation note

Per user preference, the actual `.scm` authoring and build-debug loop are to
be delegated to a lower-cost model (Haiku/Sonnet subagent).
