{...}: {
  security.pam.services = {
    system-auth.nodelay = true;
    systemd-user.nodelay = true;
    su.nodelay = true;
    sudo.nodelay = true;
    polkit-1.nodelay = true;
    login.nodelay = true;
  };
}
