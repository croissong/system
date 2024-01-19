{
  pkgs ? import <nixpkgs> {},
  versions,
}: {
  gtrash = pkgs.callPackage ./gtrash.nix {inherit versions;};
  git-repo-manager = pkgs.callPackage ./git-repo-manager.nix {};
  gitwatch = pkgs.callPackage ./gitwatch.nix {};
}
