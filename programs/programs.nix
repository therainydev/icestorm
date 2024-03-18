{ config, pkgs, ... }: {
	programs = {
		git = {
			enable = true;
			lfs.enable = true;
		};
		hyprland.enable = true;
		ssh = {
			ciphers = [ "aes256-gcm@openssh.com" "chacha20-poly1305@openssh.com" "aes256-ctr" ];
			extraConfig = ''
				compression no
				hashknownhosts yes
				enableescapecommandline yes
				serveraliveinterval 6
				serveralivecountmax 10
				tcpkeepalive no
			'';
			hostKeyAlgorithms = [ "ssh-ed25519-cert-v01@openssh.com" "ssh-ed25519" ];
			kexAlgorithms = [ "sntrup761x25519-sha512@openssh.com" "curve25519-sha256" "curve25519-sha256@libssh.org" ];
			macs = [ "hmac-sha2-512-etm@openssh.com" "hmac-sha2-256-etm@openssh.com" ];
		};
		tmux.enable = true;
		traceroute.enable = true;
		zsh.enable = true;
	};
}
