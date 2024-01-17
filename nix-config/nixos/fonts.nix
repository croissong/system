{pkgs, ...}: {
  fonts.packages = with pkgs; [
    font-awesome
    hack-font
  ];
}
