{
  stdenv,
  fetchzip,
  versions,
}:
stdenv.mkDerivation {
  pname = "protocurl";
  version = versions.protocurl.version;
  src = fetchzip {
    url = versions.protocurl.url;
    sha256 = versions.protocurl.sha;
    stripRoot = false;
  };

  installPhase = ''
    install -m755 -D bin/protocurl $out/bin/protocurl
  '';

  meta = {
    homepage = "https://github.com/qaware/protocurl";
    description = "cURL for Protobuf";
  };
}
