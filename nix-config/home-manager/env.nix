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
    NIXOS_OZONE_WL = "1"; # https://nixos.wiki/wiki/Wayland
    PAGER = "moar";
    PASSWORD_STORE_DIR = "$HOME/Pass/password-store";
    RIPGREP_CONFIG_PATH = "${config.xdg.configHome}/ripgrep/config";
    SOPS_AGE_KEY_FILE = "${config.xdg.configHome}/age/identity.age";
    SUMMON_PROVIDER = "${pkgs.gopass-summon-provider.outPath}/bin/gopass-summon-provider";
    TF_CLI_CONFIG_FILE = "$XDG_CONFIG_HOME/terraform/terraformrc";
    VISUAL = "emacsclient -c";
    WOBSOCK = "$XDG_RUNTIME_DIR/wob.sock";

    # bin overrides
    CARGO_BIN = "${CARGO_HOME}/bin";
    KREW_ROOT = "$XDG_STATE_HOME/.krew";
    NIMBLE_BIN = "$HOME/.nimble/bin";
    PATH = "$PATH:$GOPATH/bin:$KREW_ROOT/bin:$NIMBLE_BIN:$CARGO_BIN";

    # dot overrides sponsored by xdg-ninja
    AZURE_CONFIG_DIR = "$XDG_DATA_HOME/azure";
    GRADLE_USER_HOME = "$XDG_DATA_HOME/gradle";
    GRIPHOME = "$XDG_CONFIG_HOME/grip";
    DOCKER_CONFIG = "$XDG_CONFIG_HOME/docker";
    ELECTRUMDIR = "$XDG_DATA_HOME/electrum";
    RUSTUP_HOME = "$XDG_DATA_HOME/rustup";
    VAGRANT_HOME = "$XDG_DATA_HOME/vagrant";
    PSQL_HISTORY = "$XDG_DATA_HOME/psql_history";
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
    };
  };
}
