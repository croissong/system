{config, ...}: {
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

      localVariables = {
      };
    };
  };
}
