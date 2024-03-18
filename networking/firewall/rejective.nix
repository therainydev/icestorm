{ config, ... }: {
	networking.firewall = {
		allowPing = true;
		rejectPackets = true;
		logRefusedConnections = true;
		logRefusedPackets = true;
	};
}
