{pkgs, ...}: {
  imports = [
    ./hardware-configuration-vm.nix
  ];
  environment.sessionVariables = {
    "BON_VM" = "true";
  };

  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  environment.systemPackages = with pkgs; [
    glxinfo
  ];
}
