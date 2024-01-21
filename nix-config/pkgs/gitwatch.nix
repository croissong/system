{
  stdenv,
  fetchFromGitHub,
  versions,
}:
stdenv.mkDerivation rec {
  pname = "gitwatch";
  version = versions.gitwatch.version;
  src = fetchFromGitHub {
    owner = "gitwatch";
    repo = "gitwatch";
    rev = "v${version}";
    sha256 = versions.gitwatch.sha;
  };

  installPhase = ''
    install -m755 -D gitwatch.sh $out/bin/gitwatch
  '';

  meta = {
    homepage = "https://github.com/gitwatch/gitwatch";
    description = "Watch a file or folder and automatically commit changes to a git repo easily.";
  };
}
