{pkgs, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    tmp.cleanOnBoot = true;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelParams = [
      # Allow flashrom to work
      "iomem=relaxed"
    ];
  };
}
