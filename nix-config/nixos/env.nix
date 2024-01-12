{
  config,
  pkgs,
  ...
}: {
  environment = {
    defaultPackages = [];
    shells = [pkgs.zsh];
  };

  # TODO: move to HM
  environment.systemPackages = with pkgs; [
    emacs
    git
    mtr
    python3

    iproute2

    # vagrant / tmp
    rsync
    ckbcomp
  ];
}
