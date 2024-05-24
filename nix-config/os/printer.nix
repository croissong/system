{pkgs, ...}: {
  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [gutenprint];
    };

    avahi = {
      enable = true;
      openFirewall = true;
      nssmdns = true;
    };
  };

  hardware.sane = {
    enable = true;
    extraBackends = [pkgs.sane-airscan];
  };
}
