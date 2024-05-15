{
  pkgs,
  config,
  ...
}: {
  systemd.user = {
    services = {
      backup = {
        Unit = {
          Description = "autorestic backup";
        };

        Service = {
          Type = "oneshot";
          ExecStart = "${pkgs.autorestic}/bin/autorestic --ci cron";
          ExecStopPost = "${pkgs.service-status.out}/bin/service-status backup";
        };
      };

      "gitwatch-notes" = {
        Unit = {
          Description = "Gitwatch notes";
        };
        Service = {
          ExecStart = ''
            ${pkgs.gitwatch}/bin/gitwatch -s 600 -m "chore: update docs" ${config.home.homeDirectory}/dot/notes/
          '';
          ExecStop = "/bin/true";
        };

        Install = {
          WantedBy = ["default.target"];
        };
      };
    };

    timers = {
      backup = {
        Unit = {
          Description = "autorestic backup";
        };

        Timer = {
          Unit = "backup.service";
          OnCalendar = "0/2:00:00";
          AccuracySec = "10min";
        };

        Install = {
          WantedBy = ["timers.target"];
        };
      };
    };
  };
}
