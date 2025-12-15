{ pkgs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    config = null;

    # managed in dotfiles
    extraConfigEarly = ''
      include ./main.conf
    '';
  };

  programs = {
    swaylock = {
      enable = true;
      settings = {
        color = "282828";
        hide-keyboard-layout = true;
      };
    };
  };

  services = {
    # https://wiki.nixos.org/wiki/Swayidle
    swayidle =
      with pkgs;
      let
        lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
        display = status: "swaymsg 'output * power ${status}'";
      in
      {
        enable = true;

        timeouts = [
          {
            timeout = 1200;
            command = display "off";
            resumeCommand = display "on";
          }
          {
            timeout = 2400;
            command = "${systemd}/bin/systemctl suspend";
          }
        ];

        events = [
          {
            event = "before-sleep";
            command = (display "off") + "; " + lock;
          }
          {
            event = "after-resume";
            command = display "on";
          }
          {
            event = "lock";
            command = (display "off") + "; " + lock;
          }
          {
            event = "unlock";
            command = display "on";
          }
        ];
      };

    wlsunset = {
      enable = true;
      latitude = "51.3";
      longitude = "9.5";
      temperature.night = 2000;
    };

    batsignal = {
      enable = true;
      extraArgs = [
        "-w"
        "30"
        "-c"
        "15"
        "-d"
        "10"
      ];
    };

    cliphist = {
      enable = true;
      extraOptions = [
        "-max-items"
        "10"
      ];
    };

    mako.enable = true;
  };
}
