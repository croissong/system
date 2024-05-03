{pkgs, ...}: {
  nix = {
    package = pkgs.nixVersions.latest;

    settings = {
      experimental-features = "nix-command flakes";
      accept-flake-config = true;
      auto-optimise-store = true;
      use-xdg-base-directories = true;

      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "tree-grepper.cachix.org-1:Tm/owXM+dl3GnT8gZg+GTI3AW+yX1XFVYXspZa7ejHg="
      ];
      trusted-users = ["root" "@wheel"];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
