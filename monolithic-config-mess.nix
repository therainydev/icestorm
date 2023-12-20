{ config, pkgs, ... }:
{
	imports = [
		./networks.nix
		./services/setwlmac.nix
		./users/ice.nix
	];

	boot = {
		loader = {
			efi = {
				canTouchEfiVariables = true;
				efiSysMountPoint     = "/boot";
			};
			grub = {
				enable      = true;
				efiSupport  = true;
				device      = "nodev";
				useOSProber = true;
			};
			timeout = null;
		};
		supportedFilesystems = [ "btrfs" "ntfs" ];
		tmp.useTmpfs = true;
		kernel.sysctl = {
			"net.ipv4.ip_default_ttl" = 255;
		};
	};

	hardware.pulseaudio = {
		enable       = true;
		support32Bit = true;
	};

	networking = {
		enableIPv6  = false;
		nameservers = [ "1.1.1.1" "1.0.0.1" ];
		timeServers = [ "time.cloudflare.com" ];
		firewall = {
			allowedTCPPorts = [ 80 443 585 ];
			allowedUDPPorts = [ 443 ];
			allowPing = true;
			rejectPackets = true;
			logRefusedConnections = true;
			logRefusedPackets = true;
		};
		useNetworkd = true;
		wireless.enable = true;
		# networks are in networks.nix, not published because you don't deserve to know my wifi passwords
	};

	systemd = {
		network = {
			enable = true;
			wait-online.enable = false;
		};
	};
	
	time = {
		#hardwareClockInLocalTime = true; # winbloze moment
		timeZone = "Etc/UTC";
	};

	i18n = {
		defaultLocale = "en_US.UTF-8";
		extraLocaleSettings = {
			LC_ADDRESS        = "en_US.UTF-8";
			LC_IDENTIFICATION = "en_US.UTF-8";
			LC_MEASUREMENT    = "en_US.UTF-8";
			LC_MONETARY       = "en_US.UTF-8";
			LC_NAME           = "en_US.UTF-8";
			LC_NUMERIC        = "en_US.UTF-8";
			LC_PAPER          = "en_US.UTF-8";
			LC_TELEPHONE      = "en_US.UTF-8";
			LC_TIME	          = "en_US.UTF-8";
		};
	};

	console.keyMap = "dvorak";

	services = {
		hardware = {
			bolt.enable = true;
		};
		logind = {
			lidSwitchExternalPower = "ignore";
			extraConfig = "NAutoVTs=12";
		};
		nginx = {
			enable = false; #TODO
		};
		openssh = {
			enable = true;
			ports = [ 585 ];
			banner = " * contour.notomne.dev: welcome(?)\n";
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
					patches = attrs.patches ++ [ "/etc/nixos/icestorm/eduroam.patch" ];
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
		cpufetch
		dolphin
		file
		gimp
		gnome.cheese
		gnupg
		go-2fa
		grimblast
		hyfetch
		hyprpaper
		jq
		kitty
		libreoffice-fresh
		librewolf
		lighttpd # TODO: run lighttpd as a service
		lsof
		nixos-option
		nmap
		pfetch-rs
		pinentry-curses
		pv
		python311Full
		rustc
		smartmontools
		tcpdump
		tofi
		ungoogled-chromium
		unzip
		units
		vim
		vlc
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
				serveraliveinterval 5
				serveralivecountmax 40
				tcpkeepalive no
			'';
			hostKeyAlgorithms = [ "ssh-ed25519-cert-v01@openssh.com" "ssh-ed25519" ];
			kexAlgorithms = [ "sntrup761x25519-sha512@openssh.com" "curve25519-sha256" "curve25519-sha256@libssh.org" ];
			macs = [ "hmac-sha2-512-etm@openssh.com" "hmac-sha2-256-etm@openssh.com" ];
			knownHosts = {
				"github.com" = {
					publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
				};
			};
		};
		tmux.enable = true;
		traceroute.enable = true;
		zsh.enable = true;
	};

	system.stateVersion = "23.05";
}
