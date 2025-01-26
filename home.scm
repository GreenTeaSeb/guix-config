(use-modules (gnu)
	     (gnu packages)
	     (sveb packages fonts)
       (gnu services)
	     (guix channels)
             (gnu home)
             (gnu home services)
             (gnu home services desktop)
             (gnu home services sound)
             (gnu home services shells)
             (gnu home services dotfiles)
	     (gnu home services guix))

(home-environment
  (packages (specifications->packages (list "firefox"
					    "darktable"
              				    "glibc-locales"
					    "signal-desktop"
					    "pavucontrol"
					    "bemenu"
					    "okular"
					    "dolphin"
					    "zoxide"
					    "fzf"
					    "python"
					    "gwenview"
							"bluedevil"
							"qbittorrent"
					    "kitty"
					    "j4-dmenu-desktop"
							"emacs"
							"icedove-wayland"
							"vlc"
							"font-jetbrainsmono-nerd"
							"font-monaspace-nerd"
					    "font-google-noto-sans-cjk"
					    "font-google-noto"
							"yaru-theme"
					    "j4-dmenu-desktop"
							"direnv"
							"shared-mime-info"
							"qtwayland"
							"qt5ct"
							"lxappearance"
					    "xdg-desktop-portal-wlr"
					    "xdg-desktop-portal-gtk"
					    "xdg-user-dirs"
					    "xdg-utils"
					    "flatpak-xdg-utils"
					    "mako"
					    "waybar"
					    "mesa-utils"
					    "eza"
					    "grimshot"
					    "zsh-autosuggestions"
					    "zsh-completions"
					    "zsh-autopair"
					    "zsh-syntax-highlighting"
					    "slurp")))

  (services
   (list (service home-zsh-service-type
		(home-zsh-configuration
		    (zshrc (list (local-file ".zshrc" "zshrc")))
		    (zprofile (list (local-file ".zprofile" "zprofile")))))

  	(service home-dbus-service-type)

		(service home-pipewire-service-type)

		(simple-service `sway-conf home-xdg-configuration-files-service-type
			  (list `("sway", (local-file "sway" #:recursive? #t)))
		)
	
		(simple-service `waybar-conf home-xdg-configuration-files-service-type
			  (list `("waybar", (local-file "waybar" #:recursive? #t)))
		)

		(simple-service `nix-conf home-xdg-configuration-files-service-type
			  (list `("nix", (local-file "nix" #:recursive? #t)))
		)

		(simple-service `fish-conf home-xdg-configuration-files-service-type
			  (list `("fish", (local-file "fish" #:recursive? #t)))
		)

		(simple-service `emacs-conf home-xdg-configuration-files-service-type
			  (list `("emacs", (local-file "emacs" #:recursive? #t)))
		)

		(simple-service `helix-conf home-xdg-configuration-files-service-type
			  (list `("helix", (local-file "helix" #:recursive? #t)))
		)

		(simple-service `antidote-conf home-xdg-configuration-files-service-type
		 	  (list `("zsh/.zsh_plugins.txt", (local-file "antidote/zsh_plugins.txt" #:recursive? #t)))
		)

		(simple-service `podman-conf home-xdg-configuration-files-service-type
			  (list `("containers", (local-file "containers" #:recursive? #t)))
		)
		(simple-service `xdg-user-dirs home-xdg-configuration-files-service-type 
			 `(("user-dirs.dirs", (plain-file "user-dirs.dirs" (string-append
											"XDG_DESKTOP_DIR=\"$HOME/Desktop\"\n"
											"XDG_DOCUMENTS_DIR=\"$HOME/Documents\"\n"
											"XDG_DOWNLOAD_DIR=\"$HOME/Downloads\"\n"
											"XDG_MUSIC_DIR=\"$HOME/Music\"\n"
											"XDG_PICTURES_DIR=\"$HOME/Pictures\"\n"
											"XDG_PUBLICSHARE_DIR=\"$HOME/Public\"\n"
											"XDG_TEMPLATES_DIR=\"$HOME/Templates\"\n"
											"XDG_VIDEOS_DIR=\"$HOME/Videos\"\n")))))

		(simple-service `env home-environment-variables-service-type
	                          '(("XDG_CURRENT_DESKTOP" . "sway")
	                            ("XDG_SESSION_TYPE" . "wayland")
	                            ("RTC_USE_PIPEWIRE" . "true")
	                            ("SDL_VIDEODRIVER" . "wayland")
	                            ("MOZ_ENABLE_WAYLAND" . "1")
	                            ("CLUTTER_BACKEND" . "wayland")
	                            ("ELM_ENGINE" . "wayland_egl")
	                            ("ECORE_EVAS_ENGINE" . "wayland-egl")
	                            ("QT_QPA_PLATFORM" . "")
															("QT_QPA_PLATFORMTHEME" . "qt5ct")
	                            ("_JAVA_AWT_WM_NONREPARENTING" . "1")
															("NIX_CONF_DIR" . "$XDG_CONFIG_HOME/nix/")
															("XDG_MENU_PREFIX" . "arch-")
				    									("XDG_DATA_DIRS" . "/home/sveb/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"))))))

