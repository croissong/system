{ ... }:
{
  nix = {
    # needed in addition to the OS one, to clean up the user profile
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
