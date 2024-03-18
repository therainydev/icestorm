{ config, pkgs, ... }: {
	imports = [
		../networking/wireless.nix
	];
	boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
	services.logind.lidSwitchExternalPower = "ignore";
}
