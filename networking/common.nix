{ config, ... }: {
	networking = {
		enableIPv6  = false;
		nameservers = [ "1.1.1.1" "1.0.0.1" ];
		timeServers = [ "time.cloudflare.com" ];
		useNetworkd = true;
	};
}
