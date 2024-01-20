{
  pkgs,
  writeShellApplication,
}:
writeShellApplication {
  name = "service-status";

  runtimeInputs = with pkgs; [coreutils moreutils jq];

  text = builtins.readFile ./service-status.sh;
}
