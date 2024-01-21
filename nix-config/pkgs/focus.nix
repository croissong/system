{
  stdenv,
  fetchurl,
  versions,
}:
stdenv.mkDerivation {
  pname = "focus";
  version = versions.focus.version;
  src = fetchurl {
    url = versions.focus.url;
    sha256 = versions.focus.sha;
  };
  sourceRoot = ".";
  installPhase = ''
    install -m755 -D focus $out/bin/focus
  '';
  meta = {
    homepage = "https://github.com/ayoisaiah/focus";
    description = "A fully featured productivity timer for the command line, based on the Pomodoro Technique";
  };
}
