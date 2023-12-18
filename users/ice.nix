{ config, pkgs, ... }:
{
	users.users.ice = {
		isNormalUser = true;
		description  = "!omne";
		extraGroups  = [ "audio" "input" "wheel" ];
		packages     = with pkgs; [
			microsoft-edge
			mprime
		];
		shell        = pkgs.zsh;
	};
}
