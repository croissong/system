{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bash
    coreutils
    emacs30
    git
    gnupg
    home-manager
  ];
}
