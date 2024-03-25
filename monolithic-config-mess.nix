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
			#banner = "welcome to " + name + ".rainy.test\n";
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
}
