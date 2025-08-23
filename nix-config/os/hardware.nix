{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Accelerated_Video_Playback
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
      ];
    };

    intel-gpu-tools.enable = true;
  };

  # verification
  environment.systemPackages = with pkgs; [
    libva-utils
  ];
}
