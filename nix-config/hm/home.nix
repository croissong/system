# https://nix-community.github.io/home-manager/options.html
# https://mipmip.github.io/home-manager-option-search/
{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops

    # TODO
    # ./backup.nix
    ./dev.nix
    ./emacs.nix
    ./env.nix
    ./firefox.nix
    ./gpg.nix
    ./pkgs.nix
    ./pim.nix
    ./secrets.nix
    ./services.nix
    ./shell.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
      outputs.overlays.emacs-overlay
      outputs.overlays.tree-grepper
    ];
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "moi";
    homeDirectory = "/home/moi";
    enableNixpkgsReleaseCheck = false;

    pointerCursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
    };

    language = {
      base = "en_US.UTF-8";

      ctype = "de_DE.UTF-8";
      numeric = "de_DE.UTF-8";
      time = "de_DE.UTF-8";
      collate = "de_DE.UTF-8";
      monetary = "de_DE.UTF-8";
      paper = "de_DE.UTF-8";
      name = "de_DE.UTF-8";
      address = "de_DE.UTF-8";
      telephone = "de_DE.UTF-8";
      measurement = "de_DE.UTF-8";
    };
  };

  programs.home-manager.enable = true;
  news.display = "silent";

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
