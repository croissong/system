{
  config,
  outputs,
  pkgs,
  ...
}:
{
  home.sessionVariables = rec {
    BROWSER = "firefox";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    DIFFPROG = "delta";
    DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
    DOT = "${config.home.homeDirectory}/dot";
    NH_FLAKE = "path://${DOT}/system/nix-config";
    MOOR = "--no-statusbar --no-linenumbers --quit-if-one-screen";
    NIXOS_OZONE_WL = "1"; # https://nixos.wiki/wiki/Wayland
    PAGER = "moor";
    RIPGREP_CONFIG_PATH = "${config.xdg.configHome}/ripgrep/config";
    AGE_IDENTITY_FILE = "${config.xdg.configHome}/age/identity.age";
    AGE_RECIPIENTS_FILE = "${config.xdg.configHome}/age/public-key.txt";
    SOPS_AGE_KEY_FILE = AGE_IDENTITY_FILE;
    SUMMON_PROVIDER = "${pkgs.gopass-summon-provider.outPath}/bin/gopass-summon-provider";
    TF_CLI_CONFIG_FILE = "${config.xdg.configHome}/terraform/terraformrc";
    WOBSOCK = "$XDG_RUNTIME_DIR/wob.sock";

    # bin overrides
    CARGO_BIN = "${CARGO_HOME}/bin";
    KREW_ROOT = "${config.xdg.stateHome}/.krew";
    NIMBLE_BIN = "$HOME/.nimble/bin";
    PATH = "$PATH:$GOPATH/bin:$KREW_ROOT/bin:$NIMBLE_BIN:$CARGO_BIN";

    # dot overrides sponsored by xdg-ninja
    AZURE_CONFIG_DIR = "${config.xdg.dataHome}/azure";
    ELECTRUMDIR = "${config.xdg.dataHome}/electrum";
    DOCKER_CONFIG = "${config.xdg.configHome}/docker";
    GRADLE_USER_HOME = "${config.xdg.dataHome}/gradle";
    GRIPHOME = "${config.xdg.configHome}/grip";
    NIMBLE_DIR = "${config.xdg.dataHome}/nimble";
    LESSHISTFILE = "${config.xdg.stateHome}/less/history";
    PSQL_HISTORY = "${config.xdg.dataHome}/psql_history";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    VAGRANT_HOME = "${config.xdg.dataHome}/vagrant";
  }
  // outputs.vars.env;

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
    };
  };

  # make all env variables available in systemd user services
  # e.g. required to get correct SSH_AUTH_SOCK & GNUPGHOME in emacs
  systemd.user.sessionVariables = config.home.sessionVariables // {
    EDITOR = toString config.home.sessionVariables.EDITOR;
    VISUAL = toString config.home.sessionVariables.VISUAL;
    JAVA_11_HOME = toString config.home.sessionVariables.JAVA_11_HOME;
  };
}
