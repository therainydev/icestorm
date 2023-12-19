# see: configuration.nix(5)
#      nixos manual: `nixos-help`

{ config, pkgs, ... }:
{
	imports = [
		./monolithic-config-mess.nix
		./hardware-configuration.nix
	];
}
