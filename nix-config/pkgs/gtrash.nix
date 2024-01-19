{
  fetchurl,
  versions,
  stdenv,
}:
stdenv.mkDerivation {
  pname = "gtrash";
  version = versions.gtrash.version;
  src = fetchurl {
    url = versions.gtrash.url;
    sha256 = versions.gtrash.sha;
  };

  sourceRoot = ".";
  installPhase = ''
    install -m755 -D gtrash $out/bin/gtrash
  '';
}
