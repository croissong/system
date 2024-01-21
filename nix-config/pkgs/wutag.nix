{
  stdenv,
  fetchurl,
  versions,
}:
stdenv.mkDerivation {
  pname = "wutag";
  version = versions.wutag.version;
  src = fetchurl {
    url = versions.wutag.url;
    sha256 = versions.wutag.sha;
  };

  installPhase = ''
    install -m755 -D wutag $out/bin/wutag
  '';

  meta = {
    homepage = "https://github.com/vv9k/wutag";
    description = "CLI Tool for tagging and organizing files by tags";
  };
}
