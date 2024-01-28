{pkgs, ...}: {
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
    swayidle = {
      enable = true;
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.swaylock}/bin/swaylock";
        }
        {
          event = "after-resume";
          command = "${pkgs.sway}/bin/swaymsg 'output * power on'";
        }
      ];
      timeouts = [
        {
          timeout = 1200;
          command = "${pkgs.sway}/bin/swaymsg 'output * power off'";
          resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * power on";
        }
        {
          timeout = 2400;
          command = "${pkgs.systemd}/bin/systemctl suspend";
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
      extraArgs = ["-w" "30" "-c" "15" "-d" "10"];
    };

    cliphist = {
      enable = true;
      # TODO: `-max-items 10`
      # https://github.com/NixOS/nixpkgs/issues/46464
    };
  };
}
