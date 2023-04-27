{hmUsers, ...}: {
  home-manager.users = {inherit (hmUsers) moi;};

  users.users.moi = {
    password = "test";
    isNormalUser = true;
    extraGroups = ["wheel"];
  };
}
