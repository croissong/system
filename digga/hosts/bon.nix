{
  suites,
  pkgs,
  ...
}: {
  boot = {
    kernelParams = [
      "iomem=relaxed"
    ];
  };

  environment.systemPackages = with pkgs; [
    dmidecode
    meson
    ninja
    gcc-unwrapped
    binutils
    # qt5
    # libyamlcpp
    nvramtool
    lm_sensors
  ];
}
