{
  lib,
  fetchFromGitHub,
  unstableGitUpdater,
  mpvScripts,
}:
mpvScripts.buildLua rec {
  pname = "mpv-simple-history";

  version = "25-09-2023";
  src = fetchFromGitHub {
    owner = "Eisa01";
    repo = "mpv-scripts";
    rev = "48d68283cea47ff8e904decc9003b3abc3e2123e";
    hash = "sha256-95CAKjBRELX2f7oWSHFWJnI0mikAoxhfUphe9k51Qf4=";
  };
  passthru.updateScript = unstableGitUpdater {};

  scriptPath = "scripts/SimpleHistory.lua";

  meta = {
    description = "Stores whatever you open in a history file and abuses it with features!";
    longDescription = ''
      Stores whatever you open in a history file and abuses it with features!
      Continue watching your last played or resume previously played videos, manage and play from your history, and more...
    '';
    homepage = "https://github.com/Eisa01/mpv-scripts";
    license = lib.licenses.mit;
    # maintainers = with lib.maintainers; [croissong];
  };
}
