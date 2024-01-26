{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      font-awesome
      hack-font
      noto-fonts
    ];

    fontconfig = {
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Noto San"];
        monospace = ["Hack"];
      };
    };
  };
}
