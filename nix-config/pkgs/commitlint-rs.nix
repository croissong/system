{
  fetchFromGitHub,
  rustPlatform,
  versions,
}:
rustPlatform.buildRustPackage rec {
  pname = "commitlint-rs";
  version = versions.commitlint-rs.version;
  src = fetchFromGitHub {
    owner = "KeisukeYamashita";
    repo = "commitlint-rs";
    rev = "v${version}";
    sha256 = versions.commitlint-rs.sha;
  };
  cargoSha256 = "sha256-QxdG5BfIUDBWMfpFLMldZfmlvqnAurxiXKQmOQSrx94=";

  meta = {
    homepage = "https://github.com/KeisukeYamashita/commitlint-rs";
    description = "Lint commit messages with conventional commit messages ";
  };
}
