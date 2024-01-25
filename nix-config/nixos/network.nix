{...}: {
  services.resolved = {
    enable = true;
    dnssec = "true";
    fallbackDns = [
      "8.8.8.8"
      "8.8.4.4"
      "2001:4860:4860::8888"
      "2001:4860:4860::8844"
    ];

    extraConfig = ''
      DNSOverTLS=yes
    '';
  };

  networking = {
    hostName = "bon";
    useNetworkd = true;
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];

    wireless.iwd = {
      enable = true;
      settings = {
        Scan.DisablePeriodicScan = true;
        General.EnableNetworkConfiguration = true;
        Network = {
          EnableIPv6 = true;
          RoutePriorityOffset = 300;
          NameResolvingService = "systemd";
        };
      };
    };
    nftables.enable = true;
    firewall.enable = false;

    useDHCP = false;
  };

  systemd = {
    network = {
      enable = true;
      networks = {
        wireless = {
          matchConfig = {
            Name = "wlan*";
          };
          DHCP = "yes";
          dhcpV4Config = {
            UseDNS = false;
          };
        };
      };
    };
  };
}
