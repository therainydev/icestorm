{ config, pkgs, ... }:
{
	users.users.experiments = {
		isNormalUser = true;
		description  = "Experimentation";
		packages     = with pkgs; [];
		shell        = pkgs.zsh;
	};
}
