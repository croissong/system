{
  config,
  pkgs,
  ...
}:
let
  gitwatch =
    let
      mkService = dir: args: {
        Unit = {
          Description = "Gitwatch ${dir}";
        };
        Service = {
          ExecStart = ''
            ${pkgs.gitwatch-rs}/bin/gitwatch watch --log-level=debug ${args} ${config.home.homeDirectory}/dot/${dir}/
          '';
          ExecStop = "/bin/true";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    in
    {
      notes = mkService "notes" "";
      docs = mkService "docs" "--commit-message 'update docs'";
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
