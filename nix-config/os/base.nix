{...}: {
  # for console layout
  services.xserver = {
    xkb = {
      layout = "us";
      options = "ctrl:nocaps";
      variant = "nodeadkeys";
    };
  };
  console.useXkbConfig = true;
}
