{
  stdenv,
  fetchurl,
  installShellFiles,
  versions,
}:
stdenv.mkDerivation {
  pname = "sttr";
  version = versions.sttr.version;
  src = fetchurl {
    url = versions.sttr.url;
    sha256 = versions.sttr.sha;
  };

  sourceRoot = ".";
  installPhase = ''
    install -m755 -D sttr $out/bin/sttr
    runHook postInstall
  '';
  nativeBuildInputs = [installShellFiles];
  postInstall = ''
    installShellCompletion --cmd sttr --zsh <($out/bin/sttr completion zsh)
  '';

  meta = {
    homepage = "https://github.com/abhimanyu003/sttr";
    description = "cross-platform, cli app to perform various operations on string";
  };
}
