# https://nixos.org/manual/nixos/stable/options.html#opt-users.mutableUsers
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./vm.nix
  ];
  system = {
    stateVersion = "22.11";

    activationScripts = {
      iwd.text = ''
        mkdir -p /var/lib/iwd/
        ln -sfn /etc/nixos/files/iwd/*.psk /var/lib/iwd/
      '';
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # just for console layout
  services.xserver = {
    layout = "de";
    xkbOptions = "ctrl:nocaps";
    xkbVariant = "nodeadkeys";
  };
  console.useXkbConfig = true;

  users.mutableUsers = false;
  users.users.root.password = "test";

  users.users.moi = {
    isNormalUser = true;
    password = "test";
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
  };

  environment = {
    defaultPackages = [];
    etc = {
    };
    shells = [pkgs.zsh];
  };

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
  };

  systemd = {
    network = {
      enable = true;
      links = {
        eth = {
          linkConfig = {
            Name = "eth";
          };
          matchConfig = {
            MACAddress = "c0:0c:cc:c0:00:0c";
          };
        };
      };

      networks = {
        wired = {
          matchConfig = {
            Name = "eth";
          };
          bond = ["bond"];
          networkConfig = {
            PrimarySlave = true;
          };
        };

        bond = {
          matchConfig = {
            Name = "bond";
          };
          DHCP = "yes";
          networkConfig = {
            # TODO: Maybe required for libvirt inet
            # IPForward = "yes";
          };
        };
      };

      netdevs = {
        bond = {
          netdevConfig = {
            Name = "bond";
            Kind = "bond";
          };
          bondConfig = {
            Mode = "active-backup";
            PrimaryReselectPolicy = "always";
            MIIMonitorSec = "1s";
          };
        };
      };
    };
  };

  # use the latest Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  environment.systemPackages = with pkgs; [
    emacs
    git
    spice-vdagent
    mtr
    python310

    # vagrant / tmp
    rsync
    ckbcomp
  ];
}
