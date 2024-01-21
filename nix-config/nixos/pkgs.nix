{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    home-manager
    coreutils
    bash
  ];
}
