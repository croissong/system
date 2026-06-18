{ config, pkgs, ... }:
{

  home.shell = {
    enableBashIntegration = false;
    enableZshIntegration = false;
  };

  programs = {
    bash = {
      enable = true;
      historyFile = "${config.xdg.stateHome}/bash/history";
      profileExtra = ''
        [ "$(tty)" = "/dev/tty1" ] && exec sway
      '';
    };

    wezterm = {
      enable = true;
      extraConfig = ''
        local config = require 'main'
        return config
      '';
    };

    starship = {
      enable = true;
      enableTransience = true;
    };

    atuin = {
      enable = true;
      flags = [ "--disable-up-arrow" ];
    };

    zoxide = {
      enable = true;
      enableZshIntegration = false;
      options = [
        "--cmd"
        "c"
      ];
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    broot = {
      enable = true;
    };

    yazi = {
      enable = true;
    };
  };
}
