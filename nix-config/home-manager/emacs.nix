{pkgs, ...}: {
  services.emacs = {
    enable = true;
    package = pkgs.emacs-overlay.emacs-pgtk;
    client.enable = true;
    defaultEditor = true;
  };
}
