{suites, pkgs, ...}: {
  imports = suites.base ++ [
    ./hardware-configuration.nix
    ./fs.nix
    ./network.nix
    ./users.nix
    ./wm.nix
    ./programs.nix
    ./services.nix
    ./misc.nix
    ./environment.nix

    ./fwupd.nix

    # /vm.nix
    # ./virtualisation.nix
  ];

  system = {
    stateVersion = "22.11";
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      max-jobs = "auto";
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "iomem=relaxed"
    ];
  };

  # just for console layout
  services.xserver.xkbOptions = "ctrl:nocaps";
  console.useXkbConfig = true;

  environment.systemPackages = with pkgs; [
    emacs
    git
    mtr
    python310

    iproute2

    # vagrant / tmp
    rsync
    ckbcomp
    firefox
    pinentry-qt

    dmidecode
    chezmoi
    meson
    ninja
    gcc-unwrapped
    binutils
    # qt5
    # libyamlcpp
    nvramtool
    lm_sensors
  ];

}
