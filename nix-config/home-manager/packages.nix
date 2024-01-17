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
      sheldon
      sops
    ];
  };
in {
  home.packages =
    builtins.concatLists (lib.attrsets.collect builtins.isList packages_dict);
}
