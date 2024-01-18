{config, ...}: {
  home.sessionVariables = {
    BROWSER = "firefox";
    CARGO_BIN = "$CARGO_HOME/bin";
    CARGO_HOME = "$XDG_DATA_HOME/cargo";
    DIFFPROG = "delta";
    DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
    DOT = "${config.home.homeDirectory}/Dot";
    KREW_ROOT = "$XDG_STATE_HOME/.krew";
    MOAR = "--no-statusbar --no-linenumbers";
    NIMBLE_BIN = "$HOME/.nimble/bin";
    NIX_BIN = "$HOME/.nix-profile/bin";
    PAGER = "moar";
    PASSWORD_STORE_DIR = "$HOME/Pass/password-store";
    PATH = "$PATH:$GOPATH/bin:$NPM_CONFIG_PREFIX/bin:$KREW_ROOT/bin:$NIMBLE_BIN:$CARGO_BIN:$ZINIT_BIN:$NIX_BIN:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin";
    RIPGREP_CONFIG_PATH = "${config.xdg.configHome}/ripgrep/config";
    SOPS_AGE_KEY_FILE = "${config.xdg.configHome}/age/identity.age";
    TF_CLI_CONFIG_FILE = "$XDG_CONFIG_HOME/terraform/terraformrc";
    WOBSOCK = "$XDG_RUNTIME_DIR/wob.sock";
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
    };
  };
}
