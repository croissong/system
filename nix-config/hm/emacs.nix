{
  pkgs,
  ...
}:
let
  package =
    with pkgs;
    (nixpkgs-nixos-unstable.emacsPackagesFor emacs-overlay.emacs-pgtk).emacsWithPackages (
      epkgs: with epkgs; [
        jinx
        auctex
        pdf-tools
        treesit-grammars.with-all-grammars
      ]
    );
in
{
  services.emacs = {
    enable = true;
    package = package;
    client.enable = true;
    defaultEditor = true;
    startWithUserSession = "graphical";
  };

  home.packages = [
    package
    pkgs.emacs-lsp-booster
  ];
}
