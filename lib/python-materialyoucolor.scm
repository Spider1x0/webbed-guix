(define-module (lib python-materialyoucolor)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (gnu packages python-xyz)
  #:use-module (guix build-system pyproject)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages python-build))

(define-public python-materialyoucolor
  (package
    (name "python-materialyoucolor")
    (version "3.0.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/T-Dynamos/materialyoucolor-python")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1yxz05g681zpvxzfcvp4dwayq8hjvw773n4lixkhgxkvvan5hah8"))))
    (build-system pyproject-build-system)
    (arguments (list #:tests? #f))
    (native-inputs (list python-setuptools pybind11))
    (propagated-inputs (list python-pillow))
    (home-page "https://github.com/T-Dynamos/materialyoucolor-python")
    (synopsis "Material You color generation algorithms in Python")
    (description
     "Python implementation of Material You color generation algorithms.")
    (license license:asl2.0)))

python-materialyoucolor
