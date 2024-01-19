{
  pkgs ? import <nixpkgs> {},
  versions,
}: {
  gtrash = pkgs.callPackage ./gtrash.nix {inherit versions;};
  gitwatch = pkgs.callPackage ./gitwatch.nix {};
}
