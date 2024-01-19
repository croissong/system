{
  pkgs ? import <nixpkgs> {},
  versions,
}: {
  git-repo-manager = pkgs.callPackage ./git-repo-manager.nix {};
  gitwatch = pkgs.callPackage ./gitwatch.nix {};
  gtrash = pkgs.callPackage ./gtrash.nix {inherit versions;};
  updatecli = pkgs.callPackage ./updatecli.nix {};
}
