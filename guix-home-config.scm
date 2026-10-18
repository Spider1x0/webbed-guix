;; This is a sample Guix Home configuration which can help setup your
;; home directory in the same declarative manner as Guix System.
;; For more information, see the Home Configuration section of the manual.
(add-to-load-path "/home/spider/webbed-guide")
(define-module (guix-home-config)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (gnu services)
  #:use-module (gnu home services ssh)
  #:use-module (gnu home services desktop)
  #:use-module (gnu home services sound)
  #:use-module (gnu home services syncthing)
  #:use-module (gnu system shadow)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages nushell)
  #:use-module (packages carapace)
  #:use-module (guix gexp))

;; Nushell is NOT the login shell: it isn't POSIX, and Guix (profile
;; scripts, setup-environment, `guix shell`) expects a POSIX login shell.
;; Bash stays the login shell; launch nu through this wrapper instead (e.g.
;; as the terminal's command).  The `-l` shebang makes bash a login shell,
;; so /etc/profile and .bash_profile set up the Guix environment first; nu
;; then inherits it via exec.
(define nu-login
  (computed-file "nu-login"
    #~(begin
        (call-with-output-file #$output
          (lambda (port)
            (format port "#!~a/bin/bash -l~%exec ~a/bin/nu \"$@\"~%"
                    #$bash #$nushell)))
        (chmod #$output #o555))))

(define home-config
  (home-environment
    ;; carapace-bin ships share/nushell/vendor/autoload/carapace.nu, which
    ;; nu loads from the home profile automatically: no config.nu edits.
    (packages (list nushell carapace-bin))
    (services
      (append
        (list
          ;; Uncomment the shell you wish to use for your user:
          ;(service home-bash-service-type)
           (service home-fish-service-type)
           ;;(service home-nushell-service-type)
           (service home-pipewire-service-type) ;; New
           (service home-dbus-service-type)
           (service home-syncthing-service-type) ;; New
            (service home-openssh-service-type
               (home-openssh-configuration
                 (add-keys-to-agent "yes")  ; auto-add to agent
                 (hosts
                   (list
                     (openssh-host
                       (name "github.com")
                       (user "git")
                       (identity-file "~/.ssh/id_ed25519")
                       (extra-content "AddKeysToAgent yes"))))))
          ;(service home-zsh-service-type)

          (service home-files-service-type
           `((".local/bin/nu-login" ,nu-login)
             (".guile" ,%default-dotguile)
             (".Xdefaults" ,%default-xdefaults)))

          (service home-xdg-configuration-files-service-type
           `(("gdb/gdbinit" ,%default-gdbinit)
             ("nano/nanorc" ,%default-nanorc))))

        %base-home-services))))

home-config
