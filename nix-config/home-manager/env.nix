{...}: {
  systemd.user.sessionVariables = {
    DOT = "$HOME/Dot";
    DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
  };
}
