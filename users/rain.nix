{ config, pkgs, ... }: {
	users.users.rain = {
		isNormalUser = true;
		description = "Rainy";
		extraGroups = [ "audio" "input" "wheel" ];
		shell = pkgs.zsh;
	};
}
