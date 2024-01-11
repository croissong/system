# https://nixos.org/manual/nixos/stable/options.html#opt-users.mutableUsers
# https://search.nixos.org/options
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./fs.nix
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

  security.pam.services.su.nodelay = true;

  # not working
  security.pam.services.login.nodelay = true;
  security.pam.services.login.logFailures = true;

  environment.etc."security/faillock.conf" = {
    text = ''
      nodelay
    '';
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
    layout = "us";
    xkbOptions = "ctrl:nocaps";
    xkbVariant = "nodeadkeys";
  };
  console.useXkbConfig = true;

  environment = {
    defaultPackages = [];
    shells = [pkgs.zsh];
  };

  # use the latest Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  environment.systemPackages = with pkgs; [
    emacs
    git
    mtr
    python3

    iproute2

    # vagrant / tmp
    rsync
    ckbcomp
  ];
}
