{...}: {
  # for console layout
  services.xserver = {
    layout = "us";
    xkbOptions = "ctrl:nocaps";
    xkbVariant = "nodeadkeys";
  };
  console.useXkbConfig = true;
}
