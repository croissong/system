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

      "gitwatch-org" = {
        Unit = {
          Description = "Gitwatch org docs";
        };
        Service = {
          ExecStart = ''
            ${config.home.homeDirectory}/.nix-profile/bin/gitwatch -s 30 -m "chore: update docs" ${config.home.homeDirectory}/dot/notes/
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
