{pkgs, ...}: {
  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };

  # verification
  environment.systemPackages = with pkgs; [
    libva-utils
    intel-gpu-tools
  ];
}
