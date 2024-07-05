{
  stdenv,
  fetchurl,
  pkgs,
  versions,
}:
stdenv.mkDerivation {
  pname = "redo";
  version = versions.focus.version;
  src = fetchurl {
    url = "https://github.com/drdo/redu/releases/download/v0.1.5/redu-0.1.5-linux-x86_64.bz2";
    hash = "sha256-UT2mmnP4OcOtNhdBeJA/QRtsxovlHeGyN6o7xm0odEs=";
  };
  sourceRoot = ".";
  # buildInputs = [pkgs.bzip2];
  unpackCmd = "${pkgs.ouch}/bin/ouch decompress $curSrc";
  installPhase = ''
    ls -alh
    install -m755 -D *redu-0.1.5-linux-x86_64 $out/bin/redo
  '';
}
