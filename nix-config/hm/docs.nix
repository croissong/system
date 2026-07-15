{
  config,
  inputs,
  pkgs,
  ...
}:
{

  imports = [ inputs.gitwatch-rs.modules.gitwatch ];

  services.gitwatch = {
    notes = {
      repo_path = "${config.home.homeDirectory}/dot/notes/moi";
      args = [ "--log-level=debug" ];
      extraPackages = with pkgs; [
        bash
        coreutils
        git
        claude-code
      ];
    };
    docs = {
      repo_path = "${config.home.homeDirectory}/dot/docs/";
      args = [ "--log-level=debug" ];
    };
  };
}
