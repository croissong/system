{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        bun
        nodejs_latest
        nodePackages.wrangler
      ];

      env = {
        LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
      };
    };
  };
}
