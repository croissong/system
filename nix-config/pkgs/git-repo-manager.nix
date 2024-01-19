{
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  openssl,
}:
rustPlatform.buildRustPackage rec {
  pname = "git-repo-manager";
  version = "0.7.15";
  src = fetchFromGitHub {
    owner = "hakoerber";
    repo = "git-repo-manager";
    rev = "v${version}";
    hash = "sha256-NSr8wWBKwT8AOO/NSHhSnYeje2hkAyjtDwooa2RqTfE=";
  };
  cargoHash = "sha256-Xnue2oJ5Y0VVa1raXM703oQuFegh4wSoPxd26bVcjnQ=";

  nativeBuildInputs = [pkg-config];
  buildInputs = [openssl];

  meta = {
    homepage = "https://github.com/hakoerber/git-repo-manager";
    description = "A git tool to manage worktrees";
  };
}
