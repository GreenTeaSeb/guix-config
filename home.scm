(use-modules (gnu)
	     (gnu packages)
	     (sveb packages helix)
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
					    "gwenview"
							"bluedevil"
					    "kitty"
					    "helix"
							"font-jetbrainsmono-nerd"
							"font-monaspace-nerd"
					    "j4-dmenu-desktop"
							"direnv"
							"shared-mime-info"
					    "xdg-desktop-portal" ;; for screen sharing
					    "xdg-desktop-portal-wlr"
					    "xdg-desktop-portal-gtk"
					    "xdg-user-dirs"
					    "xdg-utils"
					    "flatpak-xdg-utils"
					    "mako"
					    "waybar"
					    "mesa-utils"
					    "qtwayland"
					    "font-google-noto-sans-cjk"
					    "font-google-noto"
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
		  (list `("sway/config", (local-file "sway/config"))
			`("sway/colors", (local-file "sway/colors")))
	 )
	
	 (simple-service `waybar-conf home-xdg-configuration-files-service-type
		  (list `("waybar/config", (local-file "waybar/config"))
			`("waybar/style.css", (local-file "waybar/style.css")))
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
                            ("QT_QPA_PLATFORM" . "wayland-egl")
                            ("_JAVA_AWT_WM_NONREPARENTING" . "1")
														("NIX_CONF_DIR" . "$XDG_CONFIG_HOME/nix/")
			    ("XDG_DATA_DIRS" . "/home/sveb/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"))))))
