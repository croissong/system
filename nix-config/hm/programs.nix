{...}: {
  programs = {
    chromium = {
      enable = true;
    };

    nix-index-database = {
      comma.enable = true;
    };
    # disable command-not-found integration
    nix-index.enableFishIntegration = false;
    command-not-found.enable = false;
  };
}
