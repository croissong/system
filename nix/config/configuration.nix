# https://nixos.org/manual/nixos/stable/options.html#opt-users.mutableUsers
# https://search.nixos.org/options
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./network.nix
    ./users.nix
    ./wm.nix
    ./programs.nix
    ./services.nix

    ./vm.nix

    ./virtualisation.nix
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
      max-jobs = "auto";
    };
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

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

  environment = {
    defaultPackages = [];
    etc = {
    };
    shells = [pkgs.zsh];
  };

  # use the latest Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  environment.systemPackages = with pkgs; [
    emacs
    git
    mtr
    python310

    iproute2

    # vagrant / tmp
    rsync
    ckbcomp
  ];
}
