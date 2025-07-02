{
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
          ]
        }";
        ExecStopPost = "${lib.getExe pkgs.je} backup";
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
        OnBootSec = "10min";
      };

      Install = {
        WantedBy = [ "timers.target" ];
      };
    };
  };
in
{
  systemd.user = {
    services.backup = backup.service;
    timers.backup = backup.timer;
  };
}
