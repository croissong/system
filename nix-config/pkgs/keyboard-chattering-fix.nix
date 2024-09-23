{
  python3Packages,
  pkgs,
  fetchFromGitHub,
}:
python3Packages.buildPythonPackage {
  pname = "keyboard-chattering-fix";
  version = "0.0.1";
  # src = ~/code/forks/KeyboardChatteringFix-Linux;
  src = fetchFromGitHub {
    owner = "croissong";
    repo = "KeyboardChatteringFix-Linux";
    rev = "master";
    hash = "sha256-hA5niM7qEqMQh6xs6T/IG9mBu+4vmkPxXTWGvNddcwE=";
  };

  propagatedBuildInputs = with pkgs; [
    python3
    python3Packages.pip
    python3Packages.libevdev
  ];

  meta = {
    homepage = "https://github.com/finkrer/KeyboardChatteringFix-Linux";
    description = "A tool for blocking mechanical keyboard chattering on Linux ";
  };
}
