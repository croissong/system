{...}: {
  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_BIN_HOME    = "$HOME/.local/bin";
    XDG_DATA_HOME   = "$HOME.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";

    PATH = [
      "${XDG_BIN_HOME}"
    ];
};
}
