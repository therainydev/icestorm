{ config, ... }:
{
	systemd.services.setwlmac = {
		description = "mac address forgery";
		wantedBy    = [ "wpa_supplicant.service" ];
		after       = [ "wpa_supplicant.service" ];
		script = ''
			export PATH=/run/current-system/sw/bin
			ip link set dev wlp0s20f3 down
			#ip link set dev wlp0s20f3 address 76:$(
			#	xxd -p -l 5 /dev/random |
			ip link set dev wlp0s20f3 address fe:fe:$(
				printf "%x" $(date +%s) |
				sed 's/../&:/g; s/:$//'
			)
			#ip link set dev wlp0s20f3 address 72:00:00:00:00:01
			ip link set dev wlp0s20f3 up
		'';
	};
}
