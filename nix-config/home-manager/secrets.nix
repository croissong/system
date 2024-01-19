{config, ...}: {
  sops = {
    # TODO (maybe): https://github.com/Mic92/sops-nix/issues/160
    age.keyFile = config.home.sessionVariables.SOPS_AGE_KEY_FILE;
    defaultSopsFile = ../secrets.yaml;
    # https://github.com/Mic92/sops-nix/issues/284
    defaultSymlinkPath = "${builtins.getEnv "XDG_RUNTIME_DIR"}/secrets";
    secrets = {
      "mail/wrk/password" = {};
      "spotify/password" = {};
    };
  };
}
