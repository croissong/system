{
  config,
  pkgs,
  ...
}: {
  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      defaultCacheTtlSsh = 1800;
      maxCacheTtl = 7200;
      maxCacheTtlSsh = 7200;
      enableSshSupport = true;
      sshKeys = ["497F97F130EA6713248DF7FA9C82A7887E51E82C"];

      extraConfig = ''
        pinentry-program = ${pkgs.pinentry-rofi.outPath}/bin/pinentry-rofi
      '';
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
