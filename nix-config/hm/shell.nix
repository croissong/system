{
  config,
  pkgs,
  ...
}: {
  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh";
      history = {
        path = "${config.xdg.dataHome}/zsh/zsh_history";
        ignoreAllDups = true;
        ignorePatterns = ["ls *" "pwd"];
      };

      defaultKeymap = "emacs";

      initExtra = ''
        . ${config.xdg.configHome}/zsh/config.zsh
      '';

      profileExtra = ''
        if [ "$(tty)" = "/dev/tty1" ]; then
          exec sway
        fi
      '';
    };

    fish = {
      enable = true;
      interactiveShellInit = ''
        source $__fish_config_dir/conf.d/config.fish
      '';
      plugins = with pkgs.fishPlugins; [
        {
          name = "fzf-fish";
          src = fzf-fish.src;
        }
      ];
    };

    starship = {
      enable = true;
      enableTransience = true;
      enableZshIntegration = false;
    };

    atuin = {
      enable = true;
      enableZshIntegration = false;
      flags = ["--disable-up-arrow"];
    };

    zoxide = {
      enable = true;
      enableZshIntegration = false;
      options = ["--cmd" "c"];
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
