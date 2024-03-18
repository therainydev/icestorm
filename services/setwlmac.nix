{ config, pkgs, ... }: {
	systemd.services.setwlmac = {
		description = "Set MAC Address";
		wantedBy    = [ "wpa_supplicant.service" ];
		after       = [ "wpa_supplicant.service" ];
		script = ''
			${pkgs.iproute2}/bin/ip link set dev wlp0s20f3 down
			${pkgs.iproute2}/bin/ip link set dev wlp0s20f3 address 02:$(
				${pkgs.unixtools.xxd}/bin/xxd -p -l 5 /dev/random |
				${pkgs.gnused}/bin/sed 's/../&:/g; s/:$//'
			)
			${pkgs.iproute2}/bin/ip link set dev wlp0s20f3 up
		'';
	};
}
