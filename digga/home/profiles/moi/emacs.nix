{
  pkgs,
  lib,
  ...
}: {
  services.emacs = {
    enable = true;
    package = pkgs.emacsPgtk;
  };
}
