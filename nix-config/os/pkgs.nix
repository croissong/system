{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bash
    coreutils
    emacs
    git
    gnupg
    home-manager
  ];
}
