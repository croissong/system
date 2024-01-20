{
  pkgs,
  writeShellApplication,
}:
writeShellApplication {
  name = "calsync";

  runtimeInputs = with pkgs; [vdirsyncer davmail khal coreutils nmap];

  text = builtins.readFile ./calsync.sh;
}
