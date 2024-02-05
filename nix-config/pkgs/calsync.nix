{buildNimPackage}:
buildNimPackage {
  name = "calsync";

  unpackPhase = ''
    cp $src/* .
  '';
  src = ./calsync;
}
