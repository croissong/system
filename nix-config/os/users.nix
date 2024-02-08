{
  config,
  pkgs,
  ...
}: {
  sops.secrets.hashedPassword.neededForUsers = true;

  programs = {
    zsh.enable = true;
    fish.enable = true;
  };

  users = {
    mutableUsers = false;

    users = {
      root = {
        hashedPasswordFile = config.sops.secrets.hashedPassword.path;
      };

      moi = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets.hashedPassword.path;
        extraGroups = ["wheel"];
        shell = pkgs.fish;
      };
    };
  };
}
