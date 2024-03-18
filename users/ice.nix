{ config, pkgs, ... }: {
	users.users.ice = {
		isNormalUser = true;
		description  = "!omne";
		extraGroups  = [ "audio" "dialout" "input" "wheel" ];
		packages     = with pkgs; [
		];
		shell        = pkgs.zsh;
	};
}
