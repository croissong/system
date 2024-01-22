{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    gpg
    home-manager
    coreutils
    bash
  ];
}
