{
  config,
  outputs,
  pkgs,
  ...
}: {
  services = {
    kdeconnect.enable = true;

    spotifyd = {
      enable = true;
      settings = {
        global = {
          username = outputs.vars.spotify.username;
          password_cmd = "cat ${config.sops.secrets."spotify/password".path}";
          device_name = "nix";
          backend = "pulseaudio";
        };
      };
    };

    pueue = {
      enable = true;
      settings = {
        shared = {};
      };
    };
  };

  systemd.user = {
    # https://github.com/francma/wob/tree/master/contrib/systemd
    services = {
      wob = {
        Unit = {
          Description = "A lightweight overlay volume/backlight/progress/anything bar for Wayland";
          PartOf = "graphical-session.target";
          After = "graphical-session.target";
          ConditionEnvironment = "WAYLAND_DISPLAY";
        };

        Service = {
          StandardInput = "socket";
          ExecStart = "${pkgs.wob}/bin/wob";
        };

        Install = {
          WantedBy = ["graphical-session.target"];
        };
      };
    };
    sockets = {
      wob = {
        Socket = {
          ListenFIFO = "%t/wob.sock";
          SocketMode = "0600";
          RemoveOnStop = "on";
          # If wob exits on invalid input, systemd should NOT shove following input right back into it after it restarts
          FlushPending = "yes";
        };

        Install = {
          WantedBy = ["sockets.target"];
        };
      };
    };
  };
}
