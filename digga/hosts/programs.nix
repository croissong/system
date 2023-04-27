{
  config,
  pkgs,
  ...
}: {
  programs.sway.enable = true;
  programs.gnupg.agent = {
     enable = true;
     pinentryFlavor = "qt";
     enableSSHSupport = true;
  };
}
