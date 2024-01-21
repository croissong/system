{
  stdenv,
  fetchzip,
  versions,
}:
stdenv.mkDerivation {
  pname = "qsv";
  version = versions.qsv.version;
  src = fetchzip {
    url = versions.qsv.url;
    sha256 = versions.qsv.sha;
    stripRoot = false;
  };

  installPhase = ''
    install -m755 -D qsv $out/bin/qsv
  '';

  meta = {
    homepage = "https://github.com/jqnatividad/qsv";
    description = "CSVs sliced, diced & analyzed";
  };
}
