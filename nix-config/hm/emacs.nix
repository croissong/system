{
  pkgs,
  lib,
  ...
}: let
  package = with pkgs;
    (emacsPackagesFor emacs-overlay.emacs-pgtk).emacsWithPackages (
      epkgs:
        with epkgs; [
          jinx
          auctex
          treesit-grammars.with-all-grammars
        ]
    );
in {
  services.emacs = {
    enable = true;
    package = package;
    client.enable = true;
    defaultEditor = true;
    # startWithUserSession = "graphical";
  };

  # Note: not working
  # required to make $DISPLAY env var available (w/o exec-path-from-shell)
  # `startWithUserSession = "graphical"`, i.e. "graphical-session.target", does not work (too soon i guess)
  systemd.user.services.emacs.Unit.After = lib.mkForce ["sway-session.target"];
  systemd.user.services.emacs.Install.WantedBy = lib.mkForce ["sway-session.target"];

  home.packages = [package pkgs.emacs-lsp-booster];
}
