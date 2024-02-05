{
  buildNimPackage,
  pkgs,
  lib,
  makeWrapper,
}:
buildNimPackage {
  name = "calsync";
  src = ./calsync;

  unpackPhase = ''
    cp $src/* .
  '';
  nativeBuildInputs = [makeWrapper];
  postInstall = ''
    wrapProgram $out/bin/calsync \
      --suffix PATH : ${with pkgs; lib.makeBinPath [vdirsyncer davmail khal]}
  '';
}
