{ config, pkgs, ... }: {
	imports = [
		./hosts/shadow.nix
	];
}
