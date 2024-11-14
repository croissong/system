{ config, pkgs, ... }:
{
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
      enableZshIntegration = false;
    };

    atuin = {
      enable = true;
      enableZshIntegration = false;
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
      enableZshIntegration = false;
      nix-direnv.enable = true;
    };

    broot = {
      enable = true;
    };

    # TODO: yazi?
  };
}
