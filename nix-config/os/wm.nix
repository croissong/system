{ pkgs, ... }:
{
  xdg.portal = with pkgs; {
    enable = true;
    xdgOpenUsePortal = false;
    extraPortals = [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      kdePackages.xdg-desktop-portal-kde
    ];
    configPackages = [ sway ];
  };

}
