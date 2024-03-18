{ config, ... }: {
	systemd.services.setwlmac = {
		description = "Set MAC Address";
		wantedBy    = [ "wpa_supplicant.service" ];
		after       = [ "wpa_supplicant.service" ];
		script = ''
			export PATH=/run/current-system/sw/bin
			ip link set dev wlp0s20f3 down
			ip link set dev wlp0s20f3 address 02:$(
				xxd -p -l 5 /dev/random |
				sed 's/../&:/g; s/:$//'
			)
			ip link set dev wlp0s20f3 up
		'';
	};
}
