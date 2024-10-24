{
  pkgs ? import <nixpkgs> { },
  system,
  inputs,
  versions,
}:
{
  gitwatch = inputs.gitwatch.packages.${system}.gitwatch;

  calsync = pkgs.callPackage ./calsync.nix { };
  focus = pkgs.callPackage ./focus.nix { inherit versions; };
  gitwatch-rs = pkgs.callPackage ./gitwatch-rs.nix { };
  redu = pkgs.callPackage ./redu.nix { inherit versions; };
  git-repo-manager = pkgs.callPackage ./git-repo-manager.nix { };
  keyboard-chattering-fix = pkgs.callPackage ./keyboard-chattering-fix.nix { };
  qsv = pkgs.callPackage ./qsv.nix { inherit versions; };
  sane-scan-pdf = pkgs.callPackage ./sane-scan-pdf.nix { inherit versions; };
  xmlformatter = pkgs.callPackage ./xmlformatter.nix { inherit versions; };
  service-status = pkgs.callPackage ./service-status.nix { };
  spotify-backup = pkgs.callPackage ./spotify-backup.nix { };
  wutag = pkgs.callPackage ./wutag.nix { inherit versions; };

  mpv-simple-history = pkgs.callPackage ./mpv-simple-history.nix { };
}
