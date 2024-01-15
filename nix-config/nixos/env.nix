{pkgs, ...}: {
  environment = {
    defaultPackages = [];
    shells = [pkgs.zsh];
  };
}
