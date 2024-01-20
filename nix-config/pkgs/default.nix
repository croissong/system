{
  pkgs ? import <nixpkgs> {},
  versions,
}: {
  commitlint-rs = pkgs.callPackage ./commitlint-rs.nix {inherit versions;};
  git-repo-manager = pkgs.callPackage ./git-repo-manager.nix {};
  gitwatch = pkgs.callPackage ./gitwatch.nix {};
  gtrash = pkgs.callPackage ./gtrash.nix {inherit versions;};
  updatecli = pkgs.callPackage ./updatecli.nix {};
}
