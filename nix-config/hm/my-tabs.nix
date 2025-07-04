{
  lib,
  pkgs,
  ...
}:
let
  my-tabs = {
    service = {
      Unit = {
        Description = "my-tabs sync";
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${lib.getExe pkgs.je} tabs dump";
      };
    };

    timer = {
      Unit = {
        Description = "my-tabs sync";
      };

      Timer = {
        Unit = "my-tabs.service";
        OnCalendar = "0/4:00:00";
        AccuracySec = "30min";
        Persistent = true;
      };

      Install = {
        WantedBy = [ "timers.target" ];
      };
    };
  };
in
{
  systemd.user = {
    services.my-tabs = my-tabs.service;
    timers.my-tabs = my-tabs.timer;
  };
}
