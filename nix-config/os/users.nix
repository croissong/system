{
  config,
  lib,
  ...
}: {
  sops.secrets.hashedPassword.neededForUsers = true;

  programs = {
    zsh.enable = true;
    fish = {
      enable = true;
      # unset default 'ls' aliases, which take precedence over custom fish functions...
      shellAliases = lib.mkForce {};
    };
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
        extraGroups = ["wheel" "incus-admin"];
      };
    };
  };
}
