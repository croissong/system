{
  pkgs,
  lib,
  ...
}: let
  packages_dict = with pkgs; {
    wm = [
      i3status-rust
      wezterm
      flashrom

      incus
    ];

    dot = [
      pkgs.emacs-overlay.emacs-pgtk
      chezmoi # Manage your dotfiles across multiple machines
      ouch
    ];
  };
in {
  home.packages =
    builtins.concatLists (lib.attrsets.collect builtins.isList packages_dict);

  systemd.user.sessionVariables.DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
}
