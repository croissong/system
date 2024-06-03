{
  python3Packages,
  pkgs,
}:
python3Packages.buildPythonPackage {
  pname = "keyboard-chattering-fix";
  version = "0.0.1";
  src = ~/code/forks/KeyboardChatteringFix-Linux;
  # src = fetchFromGitHub {
  #   owner = "finkrer";
  #   repo = "KeyboardChatteringFix-Linux";
  #   rev = "master";
  #   hash = "sha256-df9EL/Chvx1EF7QGi58FsY2irJ2na9Os0qOAbqwCEWo=";
  # };

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
