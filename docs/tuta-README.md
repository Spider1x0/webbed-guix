# Tuta on Guix

`tuta` is a prebuilt (Stage 1) package: it unpacks the official
Tutanota-desktop AppImage and patches the bundled Electron runtime — plus its
helper executables — to use Guix's `ld-linux` loader and shared libraries. No
compilation, no FUSE, no network at build time.

## Stage 0 — Flatpak (zero packaging, available now)

    flatpak install flathub com.tutanota.Tutanota
    flatpak run com.tutanota.Tutanota

## Stage 1 — this channel's prebuilt package

    guix install -L ~/webbed-guide tuta        # or add (packages tuta) to a manifest
    guix build   -L ~/webbed-guide tuta        # just build

Requires `nss-certs` in the same profile for TLS (login talks to tuta.com):

    guix install nss-certs

Run it:

    tuta

### Sandbox note

The bundled `chrome-sandbox` cannot be made setuid-root inside the Guix store.
Electron falls back to the unprivileged user-namespace sandbox, which works on
a stock Guix kernel. If launch fails with a message about the SUID sandbox
helper "not configured correctly" (e.g. user namespaces disabled), start it
with the sandbox off:

    tuta --no-sandbox

If the window fails to draw on the GPU, retry with:

    tuta --disable-gpu

## Updating (Stage 1)

1. Find the newest `tutanota-desktop-release-*` tag at
   <https://github.com/tutao/tutanota/releases>.
2. Bump `version` in `packages/tuta.scm`.
3. `guix download <AppImage URL with the new tag>` → paste the base32 into the
   `(sha256 (base32 ...))` field.
4. `guix build -L ~/webbed-guide tuta`.

## How it works (implementation)

- `trivial-build-system`: computes the SquashFS offset straight from the ELF
  header (`e_shoff + e_shnum * e_shentsize`) and runs `unsquashfs` from there —
  no execution of the AppImage, no FUSE.
- Every top-level ELF executable (main `tutanota-desktop`,
  `chrome_crashpad_handler`, `chrome-sandbox`) is `patchelf`'d to the Guix
  loader + RPATH; the `AppRun` shell script is skipped.
- Installs the tree under `<out>/share/tuta`, a `<out>/bin/tuta` launcher, the
  `.desktop` file, and icons.

## Stage 2 — build from source (future work)

Compile `tutao/tutanota` (npm + emscripten WASM Kyber) against Guix electron.
Not implemented; see `docs/specs/2026-08-05-tuta-guix-design.md`.
