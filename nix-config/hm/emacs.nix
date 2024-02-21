{pkgs, ...}: let
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
  };

  home.packages = [package];
}
