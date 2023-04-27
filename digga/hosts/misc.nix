{suites, ...}: {
  security.pam.services.su.nodelay = true;

  # not working
  security.pam.services.login.nodelay = true;
  security.pam.services.login.logFailures = true;

  environment.etc."security/faillock.conf" = {
    text = ''
      nodelay
    '';
  };
}
