(use-modules 
	(gnu)
  (gnu system privilege)
  (gnu system shadow)
	(gnu services)
  (gnu services databases)
	(gnu services desktop)
  (gnu services virtualization)
	(gnu services xorg)
  (gnu packages databases)
  (gnu packages containers)
  (gnu packages kde-plasma)
  (gnu packages libftdi)
  (gnu packages virtualization)
	(nongnu packages linux))

(use-package-modules wm
		     vim
		     video
		     certs
		     version-control
		     package-management
		     terminals
		     glib
		     polkit
		     rsync
		     tls
		     shells
         audio
         linux
		     networking)
 
(use-service-modules cups desktop networking ssh dbus docker nix virtualization containers )


(define %opentabletdriver-udev
  (file->udev-rule "70-opentabletdriver.rules"
                   (local-file "../opentabletdriver/70-opentabletdriver.rules")))

(operating-system
  (kernel linux)
  (firmware (list linux-firmware
		  amdgpu-firmware))
  (locale "en_IE.utf8")
  (timezone "Europe/Zagreb")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "libra")

  (users (cons* (user-account
                  (name "sveb")
                  (comment "Sveb")
                  (group "users")
		  (shell (file-append zsh "/bin/zsh"))
                  (home-directory "/home/sveb")
                  (supplementary-groups '("wheel" "netdev" "audio" "video" "kvm" "libvirt")))
                %base-user-accounts))

  (packages (append (list swayfx
        niri
        plasma-desktop
			  neovim
			  git
			  flatpak
			  polkit
			  rsync
			  openssl
			  podman
			  slirp4netns
			  podman-compose
			  passt
			  zsh
        mariadb
        libvirt
        libftdi
        qemu
        bluez-alsa
        bluez
        blueman
			  dbus)
		    %base-packages))

  (services 
    (cons*	(service openssh-service-type)
            (service cups-service-type)
            (service containerd-service-type) 
            (service virtlog-service-type)
            (service libvirt-service-type
               (libvirt-configuration
                (unix-sock-group "libvirt")
                (tls-port "16555")))
            (extra-special-file "/etc/qemu/host.conf"
                    (plain-file "host.conf" "allow br0\n"))
            (service bluetooth-service-type
              (bluetooth-configuration
                (auto-enable? #t)))
            (service nix-service-type
              (nix-configuration
                 (extra-config `("trusted-users = root sveb\n"
                                 "experimental-features = nix-command flakes\n"))))
            (service iptables-service-type
               (iptables-configuration))
            ; (simple-service `podman-subuid-subgid etc-service-type
            ; `(("subuid", (plain-file "subuid" (string-append "sveb" ":100000:65536\n")))
            ;   ("subgid", (plain-file "subgid" (string-append "sveb" ":100000:65536\n")))))
            ; (simple-service 'podman-subuid-subgid 
            ;     etc-service-type
            ;     `(("subuid" ,(plain-file "subuid" "sveb:100000:65536\n"))
            ;       ("subgid" ,(plain-file "subgid" "sveb:100000:65536\n"))))
            (service subids-service-type
              (subids-configuration
                (add-root? #f)
                (subuids (list (subid-range 
                                 (name "sveb")
                                 (start 100000)
                                 (count 65536))))
                (subgids (list (subid-range 
                                 (name "sveb")
                                 (start 100000)
                                 (count 65536))))))
            (udev-rules-service 'opentabletdriver %opentabletdriver-udev)
  		      (modify-services %desktop-services
                     (delete gdm-service-type))))


  (name-service-switch %mdns-host-lookup-nss)

  (privileged-programs
   (cons (privileged-program
         (program (file-append qemu "/libexec/qemu-bridge-helper"))
         (setuid? #t))
       %default-privileged-programs))

  (kernel-arguments (cons "modprobe.blacklist=hid-uclogic" %default-kernel-arguments))

  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))

  (file-systems (cons* (file-system
                         (mount-point "/home")
                         (device (uuid
                                  "5894d584-89e1-4491-ab4c-7c2b76608e3f"
                                  'btrfs))
                         (type "btrfs"))
                       (file-system
                         (mount-point "/")
                         (device (uuid
                                  "f1ec34eb-48c0-4e48-a12d-5644f6f8c5dc"
                                  'ext4))
                         (type "ext4"))
                       (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "01EE-0A35"
                                       'fat32))
                         (type "vfat")) %base-file-systems)))
