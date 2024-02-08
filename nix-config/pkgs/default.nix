{
  pkgs ? import <nixpkgs> {},
  versions,
}: {
  calsync = pkgs.callPackage ./calsync.nix {};
  commitlint-rs = pkgs.callPackage ./commitlint-rs.nix {inherit versions;};
  desed = pkgs.callPackage ./desed.nix {inherit versions;};
  focus = pkgs.callPackage ./focus.nix {inherit versions;};
  git-repo-manager = pkgs.callPackage ./git-repo-manager.nix {};
  gitwatch = pkgs.callPackage ./gitwatch.nix {inherit versions;};
  qsv = pkgs.callPackage ./qsv.nix {inherit versions;};
  sane-scan-pdf = pkgs.callPackage ./sane-scan-pdf.nix {inherit versions;};
  xmlformatter = pkgs.callPackage ./xmlformatter.nix {inherit versions;};
  service-status = pkgs.callPackage ./service-status.nix {};
  sttr = pkgs.callPackage ./sttr.nix {inherit versions;};
  updatecli = pkgs.callPackage ./updatecli.nix {};
  wutag = pkgs.callPackage ./wutag.nix {inherit versions;};

  mpv-simple-history = pkgs.callPackage ./mpv-simple-history.nix {};
}
