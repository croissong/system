{pkgs, ...}: {
  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [gutenprint];
    };

    avahi = {
      enable = true;
      openFirewall = true;
    };
  };
}
