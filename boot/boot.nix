{ config, pkgs, ... }: {
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
		tmp.useTmpfs = true;
		kernel.sysctl = {
			"net.ipv4.ip_default_ttl" = 255;
		};
		initrd.preDeviceCommands = ''
			${pkgs.neo-cowsay}/bin/cowsay --aurora -f dragon 'shadow.rainy.test'
		'';
		# TODO: use networking.hostName instead of writing "shadow" everywhere
	};
}