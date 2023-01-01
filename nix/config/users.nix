{
  config,
  pkgs,
  ...
}: {
  users.mutableUsers = false;
  users.users = {
    root.password = "test";

    moi = {
      isNormalUser = true;
      password = "test";
      extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    };
  };
}
