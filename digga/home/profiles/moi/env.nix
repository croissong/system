{
  ...
}: {
  systemd.user.sessionVariables = {
    XDG_CURRENT_DESKTOP = "sway";
    DOT = "$HOME/Dot";
  };
}
