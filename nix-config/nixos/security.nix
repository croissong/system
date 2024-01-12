{
  config,
  pkgs,
  ...
}: {
  security.pam.services = {
    su.nodelay = true;
    # not working
    login.nodelay = true;
    login.logFailures = true;
  };

  environment.etc."security/faillock.conf" = {
    text = ''
      nodelay
    '';
  };
}
