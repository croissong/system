{config, ...}: {
  systemd.user.sessionVariables = {
    DOT = "$HOME/Dot";
    RIPGREP_CONFIG_PATH = "${config.xdg.configHome}/ripgrep/config";
    NIMBLE_BIN = "$HOME/.nimble/bin";
    CARGO_BIN = "$CARGO_HOME/bin";
    NIX_BIN = "$HOME/.nix-profile/bin";
    PATH = "$PATH:$GOPATH/bin:$NPM_CONFIG_PREFIX/bin:$KREW_ROOT/bin:$NIMBLE_BIN:$CARGO_BIN:$ZINIT_BIN:$NIX_BIN:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin";
    DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
    };
  };
}
