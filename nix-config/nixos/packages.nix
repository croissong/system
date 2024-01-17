{pkgs, ...}: {
  # TODO: move some to HM
  environment.systemPackages = with pkgs; [
    git
    mtr
    python3

    home-manager
    iproute2

    # vagrant / tmp
    rsync
    ckbcomp
    coreutils
    bash
  ];
}
