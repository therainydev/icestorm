{ config, pkgs, ... }: {
	imports = [
		../networking/wireless.nix
		../programs/programs.nix
		../programs/packages.nix
	];
	boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
	services.logind.lidSwitchExternalPower = "ignore";
}
