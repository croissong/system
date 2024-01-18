# https://nix-community.github.io/home-manager/options.html
# https://mipmip.github.io/home-manager-option-search/
{outputs, ...}: {
  imports = [
    ./dev.nix
    ./emacs.nix
    ./env.nix
    ./firefox.nix
    ./gpg.nix
    ./packages.nix
    ./services.nix
    ./shell.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
      outputs.overlays.emacs-overlay
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
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
