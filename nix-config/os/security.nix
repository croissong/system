{ lib, ... }:
{
  security = {
    polkit.enable = true;

    pam.services = {
      sudo = {
        nodelay = true;
      };

      su = {
        logFailures = lib.mkForce false;
        nodelay = true;
      };

      polkit-1.nodelay = true;

      # https://nixos.wiki/wiki/Sway#Swaylock_cannot_be_unlocked_with_the_correct_password
      swaylock = { };
    };
  };

}
