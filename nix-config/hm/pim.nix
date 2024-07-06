{
  config,
  lib,
  outputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    (_: super: {
      isync = super.isync.override {
        withCyrusSaslXoauth2 = true;
      };
    })
  ];

  home.packages = with pkgs; [
    davmail
    khal
    khard
    mailctl

    ## maybe/on-demand/unused
    # swaks # Swiss Army Knife SMTP; Command line SMTP testing, including TLS and AUTH
    # mu # A collection of utilities for indexing and searching Maildirs
    # mblaze #  maildir utils
  ];

  programs = {
    mbsync = {
      enable = true;
    };

    vdirsyncer = {
      enable = true;
    };

    himalaya = {
      enable = true;
      package = pkgs.himalaya.override {
        buildFeatures = ["notmuch"];
      };
    };

    notmuch = {
      enable = true;
    };
  };

  services = {
    mbsync = {
      enable = true;
      postExec = "${pkgs.notmuch}/bin/notmuch new";
      frequency = "0/1:00:00";
    };
  };

  accounts = {
    email = {
      maildirBasePath = ".local/share/mail";

      accounts = {
        datawerk = {
          address = outputs.vars.mail.wrk.username;
          primary = true;
          flavor = "outlook.office365.com";
          realName = "Jan Möller";
          passwordCommand = "${pkgs.mailctl}/bin/mailctl access ${outputs.vars.mail.wrk.username}";
          gpg = {
            signByDefault = true;
            key = "jan.moeller0@gmail.com";
          };

          mbsync = {
            enable = true;
            create = "both";
            expunge = "both";
            extraConfig.account = {
              AuthMechs = "XOAUTH2";
            };

            patterns = ["INBOX"];
          };

          notmuch = {
            enable = true;
          };

          himalaya = {
            enable = true;
            settings = {
            };
          };
        };
      };
    };

    calendar = {
      basePath = ".local/share/calendars";
      accounts = {
        wrk_dw = {
          name = "wrk_dw";
          local = {
            fileExt = ".ics";
            type = "filesystem";
          };

          remote = {
            url = "http://localhost:1080/users/${outputs.vars.mail.wrk.username}/calendar/";
            type = "caldav";
            userName = outputs.vars.mail.wrk.username;
            passwordCommand = ["cat" config.sops.secrets."mail/wrk/password".path];
          };

          vdirsyncer = {
            enable = true;
            collections = ["calendar"];
            itemTypes = ["VEVENT"];
            timeRange = {
              start = "datetime.now() - timedelta(days=7)";
              end = "datetime.now() + timedelta(days=30)";
            };
          };
        };
        # birthdays = {
        #   name = "birthdays";
        #   primary = true;
        #   local = {
        #     type = "filesystem";
        #     path = "~/.local/share/contacts";
        #     fileExt = ".vcf";
        #   };
        #   khal = {
        #     enable = true;
        #     type = "calendar";
        #   };
        # };
      };
    };

    contact = {
      basePath = "~/.local/share/contacts";
      accounts = {
        prv = {
          name = "prv";
          local = {
            type = "filesystem";
            fileExt = ".vcf";
          };
          # TODO: when protonmail supports carddav
          # remote = {
          # };

          # vdirsyncer = {
          #   enable = true;
          # };

          # khal = {
          #   enable = true;
          #   readOnly = true;
          # };
        };
      };
    };
  };

  systemd.user = {
    services = {
      calsync = {
        Unit = {
          Description = "calsync";
        };

        Service = {
          Type = "oneshot";
          ExecStart = "${lib.getExe pkgs.calsync} --noninteractive";
          ExecStopPost = "${lib.getExe pkgs.service-status} calsync";
        };
      };
    };

    timers = {
      calsync = {
        Unit = {
          Description = "regular calsync";
          After = "network-online.target";
        };

        Timer = {
          Unit = "calsync.service";
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
