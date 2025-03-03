{
  lib,
  buildGoModule,
  makeWrapper,
  pkgs,
}:
buildGoModule {
  name = "my-tabs";
  src = /home/moi/code/moi/tabs;

  vendorHash = "sha256-QZP6kWowPuPbcPG5lyNbVgdCAMKiinXxIpB66OybP48=";

  nativeBuildInputs = [ makeWrapper ];
  postInstall = ''
    wrapProgram $out/bin/my-tabs \
      --suffix PATH : ${
        with pkgs;
        lib.makeBinPath [
          brotab
        ]
      }
  '';

  meta = {
    mainProgram = "my-tabs";
  };
}
