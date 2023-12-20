{ config, pkgs, ... }:
{
	imports = [
		./contour-hc.nix
	];
	networking = {
		hostName   = "contour";
		extraHosts = "127.0.0.1 contour.notomne.test";
	};
}
