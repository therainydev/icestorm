{ config, pkgs, ... }: {
	time.timeZone = "Etc/UTC";
	i18n = {
		defaultLocale = "en_US.UTF-8";
		extraLocaleSettings = {
			LANG              = "en_US.UTF-8";
			LANGUAGE          = "en_US:en:C:ja_JP";
			LC_ADDRESS        = "en_US.UTF-8";
			LC_IDENTIFICATION = "en_US.UTF-8";
			LC_MEASUREMENT    = "en_US.UTF-8";
			LC_MONETARY       = "en_US.UTF-8";
			LC_NAME           = "en_US.UTF-8";
			LC_NUMERIC        = "en_US.UTF-8";
			LC_PAPER          = "en_US.UTF-8";
			LC_TELEPHONE      = "en_US.UTF-8";
			LC_TIME	          = "en_US.UTF-8";
		};
		inputMethod = {
			enabled = "fcitx5";
			fcitx5.addons = with pkgs; [
				fcitx5-mozc
				fcitx5-gtk
				libsForQt5.fcitx5-qt
			];
		};
	};
	console.keyMap = "dvorak";
}
