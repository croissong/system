{config, ...}: {
  sops.secrets.password.neededForUsers = true;

  users = {
    mutableUsers = false;
    users = {
      root = {
        hashedPasswordFile = config.sops.secrets.password.path;
      };

      moi = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets.password.path;
        extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
      };
    };
  };
}
