{
  config,
  pkgs,
  lib,
  ...
}:
let
  # https://github.com/nix-community/home-manager/issues/3095
  pinentryRofi = pkgs.writeShellApplication {
    name = "pinentry-rofi-with-env";
    text = ''
      PATH="${
        lib.makeBinPath [
          pkgs.coreutils
          pkgs.rofi
        ]
      }"
      "${pkgs.pinentry-rofi}/bin/pinentry-rofi" "$@"
    '';
  };
in
{
  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      defaultCacheTtlSsh = 1800;
      maxCacheTtl = 7200;
      maxCacheTtlSsh = 7200;
      enableSshSupport = true;
      sshKeys = [ "497F97F130EA6713248DF7FA9C82A7887E51E82C" ];
      pinentry.package = pinentryRofi;
    };
  };

  programs = {
    gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
      settings = {
        keyid-format = "0xshort";
        no-greeting = true;
      };
    };
  };
}
