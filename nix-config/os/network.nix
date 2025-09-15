{
  config,
  outputs,
  pkgs,
  ...
}:
{
  services.resolved.enable = false;
  services.dnscrypt-proxy = {
    enable = true;
    settings = {
      ipv6_servers = true;
      require_dnssec = true;

      server_names = [
        "cloudflare"
        "google"
      ];
      forwarding_rules = config.sops.secrets."wrk/vpn/dns-forwarding-rules".path;
      cloaking_rules = pkgs.writeText "cloaking-rules.txt" outputs.vars.wrk.cloakingRules;
    };
  };

  # apparently not automatically written, when not using one of the "dns managers"
  environment.etc = {
    "resolv.conf".text = ''
      nameserver 127.0.0.1
      options edns0
    '';
  };
  networking = {
    resolvconf.enable = false;
    nameservers = [
      "127.0.0.1"
      "::1"
    ];

    hostName = "bon";
    useNetworkd = true;
    wireless.iwd = {
      enable = true;
      settings = {
        General = {
          # https://wiki.archlinux.org/title/iwd#iwd_keeps_roaming
          # https://www.metageek.com/training/resources/understanding-rssi/
          # iwctl station wlan0 show | grep RSSI
          RoamThreshold = "-75";
          RoamThreshold5G = "-80";
        };
      };
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
          routes = [
            {
              # https://wiki.archlinux.org/title/systemd-networkd#Speeding_up_TCP_slow-start
              InitialCongestionWindow = 30;
              InitialAdvertisedReceiveWindow = 30;
            }
          ];
        };
      };
    };
  };
}
