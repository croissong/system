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

  fileSystems."/home/moi/System" = {
    device = "Public-croissong";
    fsType = "9p";
    options = [
      "trans=virtio"
      "version=9p2000.L"
      "msize=104857600"
    ];
  };

  fileSystems."/home/moi/Dot" = {
    device = "Dot";
    fsType = "9p";
    options = [
      "trans=virtio"
      "version=9p2000.L"
      "msize=104857600"
    ];
  };
}
