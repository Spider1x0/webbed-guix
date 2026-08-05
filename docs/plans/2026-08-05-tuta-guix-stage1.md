# Tuta Mail (Stage 1 prebuilt wrapper) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Ship a working `tuta` package on Guix by unpacking the official Tutanota-desktop AppImage and wrapping its bundled Electron against Guix libraries.

**Architecture:** A `nonguix`-style prebuilt-binary package using `trivial-build-system` (no compilation). The build extracts the AppImage squashfs, installs it under `<out>/share/tuta`, `patchelf`s the bundled Electron ELF to use Guix's `ld-linux`/RPATH, wraps a `<out>/bin/tuta` launcher, and installs the `.desktop` file + icons.

**Tech Stack:** GNU Guix (Scheme), `trivial-build-system`, `patchelf`, `squashfs-tools`/`unsquashfs`, bundled Electron.

## Global Constraints

- Package name: `tuta`; file: `~/webbed-guide/packages/tuta.scm`; module: `(packages tuta)` (matches channel convention — see `herdr.scm`).
- Version: `355.260720.0` (release tag `tutanota-desktop-release-355.260720.0`).
- Source URL (verbatim): `https://github.com/tutao/tutanota/releases/download/tutanota-desktop-release-355.260720.0/tutanota-desktop-linux.AppImage`
- AppImage filename is unversioned; only the tag in the URL path carries the version.
- Keep the bundled Electron (native-module ABI safety). Do NOT substitute Guix electron in Stage 1.
- Build must NOT require network at build time (source is content-addressed) and must NOT require FUSE.
- License: `(license:non-copyleft ...)`-style — Tuta desktop is GPL-3.0; use `license:gpl3`.
- Build/test command: `guix build -L ~/webbed-guide tuta`.

---

### Task 1: Skeleton package that evaluates + pinned source hash

**Files:**
- Create: `~/webbed-guide/packages/tuta.scm`

**Interfaces:**
- Produces: package variable `tuta` in module `(packages tuta)`; `source` origin with real base32 hash.

- [ ] **Step 1: Fetch the source hash**

Run (downloads ~150 MB, prints the base32 hash):
```bash
guix download "https://github.com/tutao/tutanota/releases/download/tutanota-desktop-release-355.260720.0/tutanota-desktop-linux.AppImage"
```
Copy the `hash` (last line, base32 starting with `0`/`1`...) for Step 2.

- [ ] **Step 2: Write the skeleton module**

```scheme
(define-module (packages tuta)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system trivial)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages base)          ; glibc
  #:use-module (gnu packages gcc)           ; gcc:lib
  #:use-module (gnu packages elf)           ; patchelf
  #:use-module (gnu packages compression)   ; squashfs-tools
  #:use-module (gnu packages glib)          ; glib, dbus
  #:use-module (gnu packages gtk)           ; gtk+, cairo, pango, gdk-pixbuf, atk, at-spi2-core
  #:use-module (gnu packages gnome)         ; libsecret, libnotify
  #:use-module (gnu packages xorg)          ; libx11 etc, libxshmfence
  #:use-module (gnu packages xdisorg)       ; libxkbcommon, libdrm
  #:use-module (gnu packages gl)            ; mesa
  #:use-module (gnu packages cups)          ; cups
  #:use-module (gnu packages nss)           ; nss, nspr
  #:use-module (gnu packages xml)           ; expat
  #:use-module (gnu packages linux)         ; alsa-lib
  #:use-module (gnu packages fontutils)     ; fontconfig, freetype
  #:use-module (gnu packages image))        ; libpng

;; Source-pin bump procedure (mirror caelestia-shell.scm convention):
;;   1. bump VERSION below
;;   2. guix download <the AppImage URL with the new tag>
;;   3. paste the new base32 into (sha256 (base32 ...))
(define %version "355.260720.0")

(define-public tuta
  (package
    (name "tuta")
    (version %version)
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://github.com/tutao/tutanota/releases/download/"
             "tutanota-desktop-release-" version
             "/tutanota-desktop-linux.AppImage"))
       (file-name (string-append "tutanota-desktop-" version ".AppImage"))
       (sha256 (base32 "PASTE_HASH_FROM_STEP_1"))))
    (build-system trivial-build-system)
    (arguments (list #:builder #~(mkdir #$output)))  ; placeholder builder, replaced in Task 2
    (native-inputs (list patchelf squashfs-tools))
    (inputs (list glibc `(,gcc "lib") nss nspr at-spi2-core atk cairo cups
                  dbus expat gdk-pixbuf glib gtk+ pango mesa libx11 libxcb
                  libxcomposite libxdamage libxext libxfixes libxrandr
                  libxkbcommon libxshmfence alsa-lib libdrm libsecret
                  libnotify libpng fontconfig freetype))
    (home-page "https://tuta.com")
    (synopsis "Tuta (Tutanota) end-to-end encrypted email desktop client")
    (description
     "Prebuilt desktop client for the Tuta encrypted email service, repackaged
from the upstream AppImage: the bundled Electron runtime is patched to use
Guix's shared libraries.")
    (license license:gpl3)))
```
Replace `PASTE_HASH_FROM_STEP_1`.

- [ ] **Step 3: Verify it evaluates and inputs resolve**

Run: `guix build -L ~/webbed-guide tuta --dry-run`
Expected: prints derivation lines, NO `unbound variable` / `no code for module`.
If an input is `unbound variable`, find its module: `guix show <pkg> | grep location`, fix the matching `#:use-module`, re-run. (`gtk+` is the GTK 3 variable; `atk`/`at-spi2-core` live in `(gnu packages gtk)`.)

- [ ] **Step 4: Commit** — N/A (channel is not a git repo). Instead note completion in the plan checkbox.

---

### Task 2: Full builder — extract, install, patchelf, wrap, desktop

**Files:**
- Modify: `~/webbed-guide/packages/tuta.scm` (replace the placeholder `arguments`)

**Interfaces:**
- Consumes: `source` (AppImage), `patchelf`, `squashfs-tools`, and all lib inputs from Task 1.
- Produces: `<out>/bin/tuta` launcher; `<out>/share/tuta/` tree; `<out>/share/applications/tuta.desktop`; `<out>/share/icons/...`.

- [ ] **Step 1: Replace `(arguments ...)` with the real builder**

```scheme
(arguments
 (list
  #:modules '((guix build utils) (ice-9 ftw) (srfi srfi-1))
  #:builder
  #~(begin
      (use-modules (guix build utils) (ice-9 ftw) (srfi srfi-1))
      (let* ((out       #$output)
             (share     (string-append out "/share/tuta"))
             (bin       (string-append out "/bin"))
             (source    #+(this-package-native-input "does-not-exist")) ; see note
             (appimage  #$(package-source tuta))
             (patchelf  (string-append #$patchelf "/bin/patchelf"))
             (unsquashfs (string-append #$squashfs-tools "/bin/unsquashfs"))
             ;; RPATH from every runtime lib input:
             (lib-inputs (list #$glibc #$(this-package-input "nss") ))) ; replaced below
        #t))))
```

NOTE: the reference style above is fiddly. Use this **simpler, proven classic-style** builder instead (trivial-build-system exposes the origin as the `"source"` build input and every input under its package name):

```scheme
(arguments
 `(#:modules ((guix build utils) (ice-9 ftw) (srfi srfi-1))
   #:builder
   (begin
     (use-modules (guix build utils) (ice-9 ftw) (srfi srfi-1))
     (let* ((out        (assoc-ref %outputs "out"))
            (share      (string-append out "/share/tuta"))
            (bin        (string-append out "/bin"))
            (appimage   (assoc-ref %build-inputs "source"))
            (patchelf   (string-append (assoc-ref %build-inputs "patchelf")
                                       "/bin/patchelf"))
            (unsquashfs (string-append (assoc-ref %build-inputs "squashfs-tools")
                                       "/bin/unsquashfs"))
            (glibc      (assoc-ref %build-inputs "glibc"))
            (loader     (string-append glibc "/lib/ld-linux-x86-64.so.2"))
            ;; RPATH = every input's /lib, minus tools/source:
            (rpath (string-join
                    (filter-map
                     (lambda (in)
                       (let ((name (car in)) (path (cdr in)))
                         (and (not (member name '("source" "patchelf"
                                                  "squashfs-tools")))
                              (string-append path "/lib"))))
                     %build-inputs)
                    ":")))
       (mkdir-p share)
       (mkdir-p bin)
       ;; 1. EXTRACT squashfs without executing the AppImage or using FUSE.
       ;;    AppImage type-2 = ELF header + appended squashfs. Find the offset
       ;;    (end of ELF) with readelf, then unsquashfs from there.
       (let* ((readelf (string-append (assoc-ref %build-inputs "binutils")
                                      "/bin/readelf"))
              (offset
               (let* ((port (open-pipe* OPEN_READ readelf "-h" appimage))
                      (soff 0) (esize 0) (num 0))
                 (let loop ((line (read-line port)))
                   (unless (eof-object? line)
                     (cond
                      ((string-contains line "Start of section headers")
                       (set! soff (string->number
                                   (car (reverse (string-tokenize line))))))
                      ((string-contains line "Size of section headers")
                       (set! esize (string->number
                                    (car (reverse (string-tokenize
                                                   (car (string-split line #\()))))))))
                     (loop (read-line port))))
                 (close-pipe port)
                 (+ soff (* esize num)))))
         ;; The readelf-parse above is brittle; PREFER the --appimage-extract
         ;; path below and keep unsquashfs+offset only as documented fallback.
         #t)
       ;; --- PRIMARY extraction: run the (static) AppImage runtime ---
       (invoke "chmod" "+x" appimage)   ; may need a writable copy first
       ;; (see Step 2 for the writable-copy detail)
       #t))))
```

The extraction is the one genuinely uncertain step. Implement it in Step 2 as its own resolved decision; do not ship the brittle readelf snippet.

- [ ] **Step 2: Resolve extraction method (pick ONE, verify it produces `squashfs-root/`)**

Copy the AppImage to a writable path first (store inputs are read-only):
```scheme
(copy-file appimage "tuta.AppImage")
(chmod "tuta.AppImage" #o755)
```
Method A (preferred — no execution, deterministic). Add `squashfs-tools` (already an input) and compute the offset with the `unsquashfs` self-offset support:
```scheme
;; unsquashfs can be pointed past the ELF header. Get the offset by scanning
;; for the squashfs magic "hsqs" (0x73717368) in the file:
(invoke unsquashfs "-o" (number->string offset) "-d" "squashfs-root" "tuta.AppImage")
```
Method B (fallback — executes the bundled static runtime):
```scheme
(invoke "./tuta.AppImage" "--appimage-extract")
```
Run the build (Step 4). If Method A's offset detection is painful, use Method B; the type-2 runtime is statically linked and runs in the sandbox. Whichever works, keep it and delete the other.

- [ ] **Step 3: Install, patchelf, wrap, desktop (append to the builder `let` body)**

```scheme
;; 2. INSTALL extracted tree
(copy-recursively "squashfs-root" share)
;; 3. PATCHELF the bundled Electron main binary. Its name is usually
;;    "tutanota-desktop" or "electron" at the root of squashfs-root.
(let ((elf (or (and (file-exists? (string-append share "/tutanota-desktop"))
                    (string-append share "/tutanota-desktop"))
               (string-append share "/electron"))))
  (invoke patchelf "--set-interpreter" loader "--set-rpath" rpath elf)
  ;; 4. WRAP launcher
  (call-with-output-file (string-append bin "/tuta")
    (lambda (p)
      (format p "#!/bin/sh~%exec ~a \"$@\"~%" elf)))
  (chmod (string-append bin "/tuta") #o755)
  (wrap-program (string-append bin "/tuta")
    `("LD_LIBRARY_PATH" ":" prefix (,rpath))))
;; 5. DESKTOP FILE + ICON (from extracted tree)
(let ((desktop (car (find-files share "\\.desktop$"))))
  (install-file desktop (string-append out "/share/applications")))
(for-each
 (lambda (png) (install-file png (string-append out "/share/icons/hicolor")))
 (find-files share "tutanota.*\\.png$"))
```
Add `binutils` (for `readelf`, if Method A) and `bash-minimal`/`grep` to `native-inputs` only if a step needs them; `wrap-program` needs `bash` at runtime — add `bash-minimal` to `inputs` and reference it in the shebang if `/bin/sh` is unavailable in the wrapper (it is available via the wrapper hook, so `#!/bin/sh` is fine here).

- [ ] **Step 4: Build**

Run: `guix build -L ~/webbed-guide tuta`
Expected: succeeds, prints a `/gnu/store/...-tuta-355.260720.0` path.
If it fails on the extraction step, switch extraction method (Step 2). If patchelf fails with "not an ELF executable", `file squashfs-root/*` to find the real Electron binary name and fix the `elf` selection.

- [ ] **Step 5: Verify outputs exist**

Run:
```bash
OUT=$(guix build -L ~/webbed-guide tuta)
ls "$OUT/bin/tuta" "$OUT/share/tuta" "$OUT/share/applications"/*.desktop
```
Expected: all three exist.

- [ ] **Step 6: Commit** — N/A (not a git repo); mark checkbox done.

---

### Task 3: Runtime library closure — make it actually launch

**Files:**
- Modify: `~/webbed-guide/packages/tuta.scm` (`inputs` list only)

**Interfaces:**
- Consumes: built `<out>/bin/tuta` from Task 2.
- Produces: a `tuta` that opens its window and reaches login.

- [ ] **Step 1: Check the patched binary's unresolved libs**

Run:
```bash
OUT=$(guix build -L ~/webbed-guide tuta)
ELF=$(find "$OUT/share/tuta" -maxdepth 1 -type f -name 'tutanota-desktop' -o -name 'electron' | head -1)
guix shell glibc -- ldd "$ELF" 2>&1 | grep 'not found'
```
Expected: ideally empty. Any `X.so => not found` names a missing input.

- [ ] **Step 2: Add each missing lib to `inputs`, rebuild**

For every `not found` from Step 1, add the owning Guix package to `(inputs ...)`. Common extras Electron pulls that are NOT yet in the Task 1 list: `libxrender`, `libxtst`, `libxi`, `libxext`, `librsvg` (icons), `pciutils` (`libpci`), `libglvnd`, `wayland`, `libxext`. Find the owner with `guix show <guessed> | grep -i <soname>` or `guix locate <soname>`.
Rebuild: `guix build -L ~/webbed-guide tuta`. Repeat until Step 1 is empty.

- [ ] **Step 3: Launch it (manual, requires a display)**

Run: `$(guix build -L ~/webbed-guide tuta)/bin/tuta`
Expected: the Tuta window opens; NO `error while loading shared libraries`. If it crashes on GPU, retry with `--disable-gpu` appended in the launcher as a documented workaround.

- [ ] **Step 4: Verify login path**

In the opened app, log in to a Tuta account.
Expected: login succeeds (exercises `nss` TLS) and the app can store credentials (`libsecret`). If login fails with a TLS/cert error, ensure `nss-certs` is in the user profile (document this as a runtime requirement, not a package input).

- [ ] **Step 5: Commit** — N/A; mark checkbox done.

---

### Task 4: Docs — Stage 0 flatpak note + maintenance, finalize

**Files:**
- Create: `~/webbed-guide/docs/tuta-README.md`

**Interfaces:**
- Consumes: working `tuta` package.
- Produces: user-facing install/maintenance doc.

- [ ] **Step 1: Write the README**

```markdown
# Tuta on Guix

## Stage 0 — Flatpak (zero packaging, available now)
    flatpak install flathub com.tutanota.Tutanota
    flatpak run com.tutanota.Tutanota

## Stage 1 — this channel's prebuilt package
    guix install -L ~/webbed-guide tuta   # or add (packages tuta) to a manifest
Requires `nss-certs` in the same profile for TLS:
    guix install nss-certs

## Updating (Stage 1)
1. Find the newest `tutanota-desktop-release-*` tag on
   https://github.com/tutao/tutanota/releases
2. Bump `%version` in packages/tuta.scm.
3. `guix download <AppImage URL with new tag>` -> paste base32 into the source.
4. `guix build -L ~/webbed-guide tuta`.

## Stage 2 — build from source (future work)
Compile tutao/tutanota (npm + emscripten WASM Kyber) against Guix electron 41.
Not implemented; see docs/specs/2026-08-05-tuta-guix-design.md.
```

- [ ] **Step 2: Final acceptance build**

Run: `guix build -L ~/webbed-guide tuta && echo OK`
Expected: `OK`.

- [ ] **Step 3: Commit** — N/A; mark plan complete.

---

## Notes for the implementer

- The channel `~/webbed-guide` is NOT a git repo, so the "Commit" steps are no-ops — just tick the checkboxes.
- The single risky step is AppImage extraction (Task 2, Step 2). Budget one build iteration to settle Method A vs B; everything else is mechanical.
- Do NOT swap in Guix's `electron` — Stage 1 keeps the bundled runtime by design (spec §Architecture).
- Reference the existing `herdr.scm` in the same directory for the channel's module-header and formatting conventions.
