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
        go-mockery # A mock code autogenerator for golang
        gotools # Additional tools for Go development
        go # Core compiler tools for the Go programming language
        gopls # Language server for Go programming language
        go-tools # Developer tools for the Go programming language
        revive # Fast, configurable, extensible, flexible, and beautiful linter for Go

        ## maybe/on-demand/unused
        # ginkgo # A Modern Testing Framework for Go
        # golangci-lint # Fast linters Runner for Go
        # gotestsum # A human friendly `go test` runner
        # delve # A debugger for the Go programming language.
        # gdlv # GUI frontend for Delve
      ];

      env = {
      };
    };
  };
}
