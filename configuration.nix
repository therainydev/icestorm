# see: configuration.nix(5)
#      nixos manual: `nixos-help`

{ config, pkgs, ... }:
{
	imports = [
		./hosts/contour.nix
		./monolithic-config-mess.nix
	];
}
