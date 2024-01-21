{pkgs, ...}: {
  systemd.user.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
    ];
  };
}
