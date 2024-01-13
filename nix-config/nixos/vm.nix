{
  config,
  pkgs,
  ...
}: {
  environment.variables = {
    "WLR_RENDERER" = "pixman";
  };

  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  environment.systemPackages = with pkgs; [
    spice-vdagent
    glxinfo
  ];

  virtualisation.lxd.agent.enable = true;
}
