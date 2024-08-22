with import <nixpkgs> {};
  mkShell {
    NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [
      stdenv.cc.cc
      openssl
      # ...
    ];
    NIX_LD = lib.fileContents "${stdenv.cc}/nix-support/dynamic-linker";
  }
