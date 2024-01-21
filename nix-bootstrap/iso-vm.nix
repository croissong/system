{lib, ...}: {
  imports = [
    ./iso.nix
    ../nix-config/nixos/vm.nix
  ];

  isoImage = {
    isoName = lib.mkForce "nixos-vm.iso";
  };

  programs.bash.shellInit = builtins.readFile ./bootstrap-vm.sh;

  environment.shellAliases = {
    run = "~/shared/vm/scripts/run.sh";
  };
}
