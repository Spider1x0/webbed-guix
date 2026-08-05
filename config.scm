(add-to-load-path "/home/spider/webbed-guide")
(use-modules (gnu)
             (gnu packages nss)
             (gnu packages wm)
             (gnu system)
             (gnu packages version-control)
             (gnu packages rust-apps)
             (gnu services avahi)
             (packages elvish)
             (nongnu packages linux)
             (nongnu system linux-initrd))

(use-modules (packages sway-scroll))
(use-service-modules desktop ssh networking audio sound)
(use-package-modules certs)
(service avahi-service-type)
(operating-system
  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))
  (locale "en_US.utf8")
  (timezone "Asia/Riyadh")
  (keyboard-layout (keyboard-layout "us" "ara"))
  (host-name "Goliath")
  (users (cons* (user-account
                  (name "spider")
                  (comment "Spider")
                  (group "users")
                  (home-directory "/home/spider")
                  (supplementary-groups
                    '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))
  (packages (append
              (list niri sway-scroll git bat elvish  )
              %base-packages))
  (services (append
              (list (service openssh-service-type ))
              %desktop-services))
  (bootloader
    (bootloader-configuration
      (bootloader grub-efi-bootloader)
      (targets '("/boot/efi"))
      (keyboard-layout keyboard-layout)))
  (mapped-devices
    (list (mapped-device
            (source (uuid "8d3e69c4-d967-4748-94fb-771c737649bd"))
            (target "root")
            (type luks-device-mapping))))
  (file-systems
    (cons* (file-system
              (mount-point "/")
              (device "/dev/mapper/root")
              (type "ext4")
              (dependencies mapped-devices))
            (file-system
              (mount-point "/boot/efi")
              (device (uuid "BD76-A514" 'fat32))
              (type "vfat"))
            (file-system
            (mount-point "/mnt/nvme2tb")
            (device (uuid "4da651cb-52a8-4c20-84e1-dbd594bf3a02"))
            (type "ext4"))
            %base-file-systems)))
