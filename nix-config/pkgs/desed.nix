{
  stdenv,
  fetchurl,
  versions,
}:
stdenv.mkDerivation {
  pname = "desed";
  version = versions.desed.version;
  src = fetchurl {
    url = versions.desed.url;
    sha256 = versions.desed.sha;
  };

  dontUnpack = true;
  installPhase = ''
    install -m755 -D $src $out/bin/desed
  '';

  meta = {
    homepage = "https://github.com/SoptikHa2/desed";
    description = "Debugger for Sed: demystify and debug your sed scripts";
  };
}
