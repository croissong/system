{ pkgs, ... }: {
  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [ gutenprint ];
    };

    avahi = {
      enable = true;
      openFirewall = true;
      nssmdns4 = true;
    };
  };

  hardware = {
    printers = {
      ensurePrinters = [
        {
          name = "Moi";
          location = "Home";
          deviceUri = "ipp://HP9457A541BE8C.local:631/ipp/print";
          model = "everywhere";
        }
      ];
      ensureDefaultPrinter = "Moi";
    };

    sane = {
      enable = true;
      extraBackends = [ pkgs.sane-airscan ];
    };
  };

}
