# https://nixos.org/manual/nixos/stable/options.html#opt-users.mutableUsers
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./vagrant.nix
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

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  services.xserver = {
    layout = "de";
    xkbOptions = "ctrl:nocaps";
    xkbVariant = "nodeadkeys";
    # exportConfiguration = true;
  };
  console.useXkbConfig = true;

  users.mutableUsers = false;
  users.users.root.password = "test";

  users.users.croissong = {
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

  services.resolved.enable = true;
  networking = {
    useNetworkd = true;
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
            Name = "eth0";
          };
          matchConfig = {
            MACAddress = "c0:0c:cc:c0:00:0c";
          };
        };
      };

      networks = {
        wired = {
          matchConfig = {
            Name = "eth0";
          };
          DHCP = "yes";
          networkConfig = {
            IPForward = "yes";
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
