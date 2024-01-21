{
  config,
  pkgs,
  ...
}: {
  home.sessionVariables = rec {
    BROWSER = "firefox";
    CARGO_HOME = "$XDG_DATA_HOME/cargo";
    DIFFPROG = "delta";
    DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
    DOT = "${config.home.homeDirectory}/dot/dotfiles";
    MOAR = "--no-statusbar --no-linenumbers";

    # https://nixos.wiki/wiki/Wayland
    NIXOS_OZONE_WL = "1";

    PAGER = "moar";
    RIPGREP_CONFIG_PATH = "${config.xdg.configHome}/ripgrep/config";
    SOPS_AGE_KEY_FILE = "${config.xdg.configHome}/age/identity.age";
    SUMMON_PROVIDER = "${pkgs.gopass-summon-provider.outPath}/bin/gopass-summon-provider";
    TF_CLI_CONFIG_FILE = "$XDG_CONFIG_HOME/terraform/terraformrc";
    WOBSOCK = "$XDG_RUNTIME_DIR/wob.sock";

    CARGO_BIN = "${CARGO_HOME}/bin";
    KREW_ROOT = "$XDG_STATE_HOME/.krew";
    NIMBLE_BIN = "$HOME/.nimble/bin";
    PASSWORD_STORE_DIR = "$HOME/Pass/password-store";
    PATH = "$PATH:$GOPATH/bin:$KREW_ROOT/bin:$NIMBLE_BIN:$CARGO_BIN";
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
    };
  };
}
