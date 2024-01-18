{config, ...}: {
  programs = {
    go = {
      enable = true;
      goPath = "${config.xdg.dataHome}/go";
    };
  };
}
