{
  pkgs,
  lib,
  ...
}: let

  packages_dict = with pkgs; {

    wm = [
      i3status-rust
      wezterm
      tofi
      flashrom
    ];

    dot = [
      chezmoi # Manage your dotfiles across multiple machines
    ];
  };

in {
  home.packages =
    builtins.concatLists (lib.attrsets.collect builtins.isList packages_dict);

  systemd.user.sessionVariables.DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
}
