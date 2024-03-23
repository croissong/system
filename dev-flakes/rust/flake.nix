{
  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    fenix,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [fenix.overlays.default];
    };
  in {
    devShells.x86_64-linux.default =
      pkgs.mkShell.override {
        stdenv = pkgs.stdenvAdapters.useMoldLinker pkgs.clangStdenv;
      } {
        packages = with pkgs; [
          (pkgs.fenix.complete.withComponents [
            "cargo"
            "clippy"
            "rust-src"
            "rustc"
            "rustfmt"
          ])
          rust-analyzer-nightly
          cargo-edit
        ];

        # LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${
        #   with pkgs;
        #     lib.makeLibraryPath [
        #       wayland
        #       libxkbcommon
        #       fontconfig
        #     ]
        # }";
      };
  };
}
