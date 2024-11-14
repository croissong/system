{
  config,
  lib,
  pkgs,
  ...
}:
let
  backup = {
    service = {
      Unit = {
        Description = "resticprofile backup";
        After = "network-online.target";
        Wants = "network-online.target";
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${lib.getExe pkgs.resticprofile} backup";
        Environment = "PATH=$PATH:${
          with pkgs;
          lib.makeBinPath [
            bash
            coreutils
            fd
            git
            ripgrep
            unixtools.ping
          ]
        }";

        # https://stackoverflow.com/questions/35805354/systemd-start-service-at-boot-time-after-network-is-really-up-for-wol-purpose
        ExecStartPre = "/bin/sh -c 'while ! ping -c1 1.1.1.1; do sleep 1; done'";
        ExecStopPost = "${lib.getExe pkgs.service-status} backup";
      };
    };

    timer = {
      Unit = {
        Description = "resticprofile backup";
      };

      Timer = {
        Unit = "backup.service";
        OnCalendar = "0/4:00:00";
        AccuracySec = "10min";
        Persistent = true;
      };

      Install = {
        WantedBy = [ "timers.target" ];
      };
    };
  };

  gitwatch =
    let
      mkService = dir: args: {
        Unit = {
          Description = "Gitwatch ${dir}";
        };
        Service = {
          ExecStart = ''
            ${pkgs.gitwatch-rs}/bin/gitwatch-rs --debounce-seconds=600 ${config.home.homeDirectory}/dot/${dir}/ ${args}
          '';
          ExecStop = "/bin/true";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    in
    {
      notes = mkService "notes" "--commit-message-script ~/dot/notes/ai.fish";
      docs = mkService "docs" "--commit-message 'update docs'";
    };
in
{
  systemd.user = {
    services = {
      backup = backup.service;

      gitwatch-notes = gitwatch.notes;
      gitwatch-docs = gitwatch.docs;
    };

    timers = {
      backup = backup.timer;
    };
  };
}
