{
  stdenv,
  fetchurl,
}:
stdenv.mkDerivation {
  pname = "holos";
  version = "0.101.0";
  src = fetchurl {
    url = "https://github.com/holos-run/holos/releases/download/v0.101.0/holos_Linux_x86_64.tar.gz";
    sha256 = "sha256-Ktc7N6JAHDgFBRLXj64fQAQA7mMKic25uzYr07u8F6Y=";
  };
  sourceRoot = ".";
  installPhase = ''
    install -m755 -D holos $out/bin/holos
  '';
  meta = {
    homepage = "https://github.com/holos-run/holos";
    description = "The Holistic platform manager";
  };
}
