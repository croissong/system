{pkgs, ...}: {
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
        }
        {
          timeout = 2400;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
    };
  };
}
