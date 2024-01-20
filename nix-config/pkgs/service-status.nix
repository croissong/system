{
  pkgs,
  writeShellApplication,
}:
writeShellApplication {
  name = "service-status";

  runtimeInputs = with pkgs; [jq];

  text = builtins.readFile ./service-status.sh;
}
