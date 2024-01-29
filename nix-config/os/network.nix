{config, ...}: {
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv6_servers = true;
      require_dnssec = true;

      server_names = ["cloudflare" "google"];
      forwarding_rules = config.sops.secrets."wrk/vpn/dns-forwarding-rules".path;
    };
  };

  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };

  networking = {
    hostName = "bon";
    useNetworkd = true;
    wireless.iwd = {
      enable = true;
    };
    nftables.enable = true;
    firewall.enable = false;

    useDHCP = false;
  };

  systemd = {
    network = {
      wait-online.timeout = 5;
      enable = true;
      networks = {
        wireless = {
          matchConfig = {
            Name = "wlan*";
          };
          networkConfig.DHCP = "yes";
        };
      };
    };
  };
}
