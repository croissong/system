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
            unixtools.ping
          ]}";

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
        WantedBy = ["timers.target"];
      };
    };
  };

  gitwatch = let
    mkService = dir: {
      Unit = {
        Description = "Gitwatch ${dir}";
      };
      Service = {
        ExecStart = ''
          ${pkgs.gitwatch}/bin/gitwatch -s 600 -m "chore: update ${dir}" ${config.home.homeDirectory}/dot/${dir}/
        '';
        ExecStop = "/bin/true";
      };
      Install = {
        WantedBy = ["default.target"];
      };
    };
  in {
    notes = mkService "notes";
    docs = mkService "docs";
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
