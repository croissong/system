{
  stdenv,
  fetchurl,
  pkgs,
  versions,
}:
stdenv.mkDerivation {
  pname = "redu";
  version = versions.focus.version;
  src = fetchurl {
    url = "https://github.com/drdo/redu/releases/download/v0.2.10/redu-0.2.10-linux-x86_64.bz2";
    hash = "sha256-y3yFJjoEEccyTgInJHuwn2ETl9aSKE/ujCbmB05h4VM=";
  };
  sourceRoot = ".";
  # buildInputs = [pkgs.bzip2];
  unpackCmd = "${pkgs.ouch}/bin/ouch decompress $curSrc";
  installPhase = ''
    ls -alh
    install -m755 -D *redu-0.2.10-linux-x86_64 $out/bin/redu
  '';
}
