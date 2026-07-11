{ pkgs, ... }:
{
  xdg.portal = with pkgs; {
    enable = true;
    wlr = {
      enable = true;
      settings = {
        screencast = {
          chooser_type = "simple";
          chooser_cmd = "${slurp}/bin/slurp -f 'Monitor: %o' -or";
        };
      };
    };
  };

}
