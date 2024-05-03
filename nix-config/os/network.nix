{
  config,
  outputs,
  pkgs,
  ...
}: {
  services.resolved.enable = false;
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv6_servers = true;
      require_dnssec = true;

      server_names = ["cloudflare" "google"];
      forwarding_rules = config.sops.secrets."wrk/vpn/dns-forwarding-rules".path;
      cloaking_rules = pkgs.writeText "cloaking-rules.txt" outputs.vars.wrk.cloakingRules;
    };
  };

  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
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
    nameservers = ["127.0.0.1" "::1"];

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
          routes = [
            {
              # https://wiki.archlinux.org/title/systemd-networkd#Speeding_up_TCP_slow-start
              routeConfig = {
                InitialCongestionWindow = 30;
                InitialAdvertisedReceiveWindow = 30;
              };
            }
          ];
        };
      };
    };
  };
}
