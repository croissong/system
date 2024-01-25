{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    gnupg
    home-manager
    coreutils
    emacs
    bash
  ];
}
