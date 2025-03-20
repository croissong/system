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

  xdg.portal = with pkgs; {
    enable = true;
    xdgOpenUsePortal = false;
    extraPortals = [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      kdePackages.xdg-desktop-portal-kde
    ];
    configPackages = [ sway ];
  };

  services = {
    swayidle = with pkgs; {
      enable = true;
      extraArgs = [ "-w" ];
      events = [
        {
          event = "before-sleep";
          command = "${lib.getExe swaylock} -f";
        }
        {
          event = "after-resume";
          command = "${sway}/bin/swaymsg 'output * power on'";
        }
      ];
      timeouts = [
        {
          timeout = 1200;
          command = "${sway}/bin/swaymsg 'output * power off'";
          resumeCommand = "${sway}/bin/swaymsg 'output * power on'";
        }
        {
          timeout = 2400;
          command = "${systemd}/bin/systemctl suspend";
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
  };
}
