{ config, pkgs, ... }: {
	hardware.pulseaudio = {
		enable       = true;
		support32Bit = true;
		package = pkgs.pulseaudioFull;
	};

	systemd = {
		network = {
			enable = true;
			wait-online.enable = false;
		};
	};

	services = {
		logind = {
			extraConfig = "NAutoVTs=12";
		};
		openssh = {
			enable = true;
			ports = [ 585 ];
			banner = "rainydev's network - rainy.test\n";
		};
		printing = {
			enable = true;
		};
		resolved = {
			enable = true;
			domains = [ "~."];
			fallbackDns = [ "1.1.1.1" "1.0.0.1" ];
			extraConfig = ''
			'';
		};
		throttled = {
			enable = true;
		};
	};

	fonts.packages = with pkgs; [
		font-awesome
		noto-fonts
		noto-fonts-cjk
		noto-fonts-emoji
		victor-mono
	];

	nixpkgs = {
		config = {
			/*
			packageOverrides = pkgs: rec {
				wpa_supplicant = pkgs.wpa_supplicant.overrideAttrs (attrs: {
					patches = attrs.patches ++ [ "/etc/nixos/no-rfc5746.patch" ];
				});
			};
			*/
			permittedInsecurePackages = [ "openssl-1.1.1w" ];
			allowUnfree = true;
		};
		overlays = [
			# connect to networks that don't support rfc5746
			(final: prev: {
				wpa_supplicant = prev.wpa_supplicant.override {
					openssl = pkgs.openssl_1_1;
				};
			})
		];
	};
	environment.systemPackages = with pkgs; [
		bat
		bc
		bind
		btop
		cargo
		dolphin
		ffmpeg-full
		file
		gnome.cheese
		gnupg
		go-2fa
		grimblast
		jq
		kitty
		krita
		libreoffice-fresh
		librewolf
		libsForQt5.qt5ct
		lsof
		nasm
		neo-cowsay
		nixos-option
		nmap
		pfetch-rs
		pinentry-curses
		pv
		python311Full
		rustc
		smartmontools
		tcpdump
		texliveBasic
		tofi
		ungoogled-chromium
		unzip
		units
		vim
		vscodium
		waybar
		whois
		yt-dlp
	];
	programs = {
		git = {
			enable = true;
			lfs.enable = true;
		};
		hyprland.enable = true;
		ssh = {
			ciphers = [ "aes256-gcm@openssh.com" "chacha20-poly1305@openssh.com" "aes256-ctr" ];
			extraConfig = ''
				compression no
				hashknownhosts yes
				enableescapecommandline yes
				serveraliveinterval 6
				serveralivecountmax 10
				tcpkeepalive no
			'';
			hostKeyAlgorithms = [ "ssh-ed25519-cert-v01@openssh.com" "ssh-ed25519" ];
			kexAlgorithms = [ "sntrup761x25519-sha512@openssh.com" "curve25519-sha256" "curve25519-sha256@libssh.org" ];
			macs = [ "hmac-sha2-512-etm@openssh.com" "hmac-sha2-256-etm@openssh.com" ];
		};
		tmux.enable = true;
		traceroute.enable = true;
		zsh.enable = true;
	};
}
