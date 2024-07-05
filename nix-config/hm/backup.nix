{
  config,
  lib,
  pkgs,
  ...
}: let
  backup = {
    service = {
      Unit = {
        Description = "resticprofile backup";
        After = "network-online.target";
        Wants = "network-online.target";
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${lib.getExe pkgs.nixpkgs-pr-2.resticprofile} backup";
        Environment = "PATH=$PATH:${with pkgs;
          lib.makeBinPath [
            bash
            coreutils
            fd
            git
            ripgrep
          ]}";
        ExecStopPost = "${pkgs.service-status.out}/bin/service-status backup";
      };
    };

    timer = {
      Unit = {
        Description = "resticprofile backup";
      };

      Timer = {
        Unit = "backup.service";
        OnCalendar = "0/8:00:00";
        AccuracySec = "10min";
        Persistent = true;
      };

      Install = {
        WantedBy = ["timers.target"];
      };
    };
  };

  gitwatch = {
    notes = {
      Unit = {
        Description = "Gitwatch notes";
      };
      Service = {
        ExecStart = ''
          ${pkgs.gitwatch}/bin/gitwatch -s 600 -m "chore: update notes" ${config.home.homeDirectory}/dot/notes/
        '';
        ExecStop = "/bin/true";
      };

      Install = {
        WantedBy = ["default.target"];
      };
    };

    docs = {
      Unit = {
        Description = "Gitwatch docs";
      };
      Service = {
        ExecStart = ''
          ${pkgs.gitwatch}/bin/gitwatch -s 600 -m "chore: update docs" ${config.home.homeDirectory}/dot/docs/
        '';
        ExecStop = "/bin/true";
      };

      Install = {
        WantedBy = ["default.target"];
      };
    };
  };
in {
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
