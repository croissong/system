{
  config,
  lib,
  pkgs,
  ...
}:
let
  gitwatch =
    let
      mkService = dir: {
        Unit = {
          Description = "Gitwatch ${dir}";
        };
        Service = {
          ExecStart = ''
            ${pkgs.gitwatch-rs}/bin/gitwatch watch --log-level=debug ${config.home.homeDirectory}/dot/${dir}/
          '';
          Environment = "PATH=$PATH:${
            lib.makeBinPath [
              pkgs.bash
              pkgs.coreutils
              pkgs.git
              pkgs.aichat
            ]
          }";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    in
    {
      notes = mkService "notes";
      docs = mkService "docs";
    };
in
{
  systemd.user = {
    services = {
      gitwatch-notes = gitwatch.notes;
      gitwatch-docs = gitwatch.docs;
    };
  };
}
