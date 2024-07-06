{
  buildNimPackage,
  pkgs,
}:
buildNimPackage {
  pname = "service-status";
  version = "0.0.1";

  src = ./service-status;

  buildInputs = with pkgs; [
    libnotify
  ];

  meta = {
    mainProgram = "service_status";
  };
}
