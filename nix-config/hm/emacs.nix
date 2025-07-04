{
  pkgs,
  ...
}:
let
  package =
    with pkgs;
    (nixpkgs-nixos-unstable.emacsPackagesFor emacs-overlay.emacs-unstable-pgtk).emacsWithPackages (
      epkgs: with epkgs; [
        jinx
        auctex
        pdf-tools
        treesit-grammars.with-all-grammars
        vterm
      ]
    );
in
{
  services.emacs = {
    enable = true;
    package = package;
    client = {
      enable = true;
      arguments = [ "-r" ];
    };
    defaultEditor = true;
    startWithUserSession = "graphical";
  };

  home.packages = [
    package
    pkgs.emacs-lsp-booster
  ];
}
