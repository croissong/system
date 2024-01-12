{
  config,
  pkgs,
  ...
}: {
  environment.variables = {
    # https://github.com/NixOS/nixpkgs/blob/master/nixos/tests/sway.nix#L29
    "WLR_RENDERER" = "pixman";

    # https://github.com/swaywm/wlroots/issues/3189
    "WLR_NO_HARDWARE_CURSORS" = "1";
  };

  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  environment.systemPackages = with pkgs; [
    spice-vdagent
    glxinfo
  ];


  virtualisation.lxd.agent.enable = true;
}
