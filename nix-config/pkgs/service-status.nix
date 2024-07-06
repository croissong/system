{buildNimPackage}:
buildNimPackage {
  name = "service-status";
  src = ./service-status;

  unpackPhase = ''
    cp $src/* .
  '';

  meta = {
    mainProgram = "service_status";
  };
}
