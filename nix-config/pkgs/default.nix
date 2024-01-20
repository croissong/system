{
  pkgs ? import <nixpkgs> {},
  versions,
}: {
  calsync = pkgs.callPackage ./calsync.nix {};
  commitlint-rs = pkgs.callPackage ./commitlint-rs.nix {inherit versions;};
  git-repo-manager = pkgs.callPackage ./git-repo-manager.nix {};
  gitwatch = pkgs.callPackage ./gitwatch.nix {};
  gtrash = pkgs.callPackage ./gtrash.nix {inherit versions;};
  updatecli = pkgs.callPackage ./updatecli.nix {};
  service-status = pkgs.callPackage ./service-status.nix {};
}
