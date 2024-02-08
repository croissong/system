{...}: {
  programs = {
    chromium = {
      enable = true;
    };

    nix-index-database.comma.enable = true;
    command-not-found.enable = false;
  };
}
