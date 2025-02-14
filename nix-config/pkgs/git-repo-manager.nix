{
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  openssl,
}:
rustPlatform.buildRustPackage rec {
  pname = "git-repo-manager";
  version = "0.7.22";
  src = fetchFromGitHub {
    owner = "hakoerber";
    repo = "git-repo-manager";
    rev = "v${version}";
    hash = "sha256-ycJecaeTn9gOXsiEJApJPVNhnWY6yfOcPPTiYZYW4uc=";
  };
  cargoHash = "sha256-Hik7c79rC87DqBrBP2a/6Ed6LWsI4Dj20ttqdoslapg=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  meta = {
    homepage = "https://github.com/hakoerber/git-repo-manager";
    description = "A git tool to manage worktrees";
  };
}
