{lib, ...}: {
  security = {
    polkit.enable = true;

    pam.services = {
      sudo = {
        nodelay = true;
        fprintAuth = true;
      };

      su = {
        logFailures = lib.mkForce false;
        nodelay = true;
        fprintAuth = true;
      };

      polkit-1.nodelay = true;

      # https://nixos.wiki/wiki/Sway#Swaylock_cannot_be_unlocked_with_the_correct_password
      swaylock = {};
    };
  };

  services.fprintd = {
    enable = true;
  };
}
