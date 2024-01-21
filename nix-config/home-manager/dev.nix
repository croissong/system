{
  config,
  pkgs,
  ...
}: {
  programs = {
    go = {
      enable = true;
      goPath = "${config.xdg.dataHome}/go";
    };

    java = {
      enable = true;
      package = pkgs.temurin-bin;
    };
  };

  home.sessionVariables = {
    JAVA_HOME = "${pkgs.temurin-bin}/lib/openjdk";
    JAVA_11_HOME = "${pkgs.temurin-bin-11}/lib/openjdk";
  };
}
