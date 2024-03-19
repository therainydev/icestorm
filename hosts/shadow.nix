{ config, lib, pkgs, modulesPath, ... }: {
	networking.hostName = "shadow";
	imports = [
		(modulesPath + "/installer/scan/not-detected.nix")
		../monolithic-config-mess.nix
		../boot/boot.nix
		../locale/default.nix
		../networking/common.nix
		../networking/firewall/rejective.nix
		../type/laptop.nix
		../users/ice.nix
		../users/rain.nix
	];
	networking = {
		#extraHosts = "127.0.0.1 ${networking.hostName}.rainy.test";
	};
	services.journald.extraConfig = "SystemMaxUse=100M";
	boot.supportedFilesystems = [ "ntfs" ];
	system.stateVersion = "23.05";

	boot.initrd.availableKernelModules = [
		"xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" "sdhci_pci"
	];
	boot.initrd.kernelModules = [];
	boot.kernelModules = [];
	boot.extraModulePackages = [];

	fileSystems = {
		"/" = {
			device = "/dev/disk/by-uuid/d6b687b0-dfe3-43a7-a272-0b2f176a5431";
			fsType = "ext4";
		};
		"/boot" = {
			device = "/dev/disk/by-uuid/D996-19BC";
			fsType = "vfat";
		};
	};

	swapDevices = [];

	networking.useDHCP = true;

	nixpkgs.hostPlatform = "x86_64-linux";
	powerManagement.cpuFreqGovernor = "powersave";
	hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
}
