{pkgs, ...}: {
  environment = {
    defaultPackages = [];
    shells = [pkgs.zsh];
    localBinInPath = true;
  };
}
