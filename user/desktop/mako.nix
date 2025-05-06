# Notifications Daemon
{pkgs, ...}: {
  home.packages = [pkgs.mako];
  services.mako.enable = true;
  services.mako.settings.defaultTimeout = 5000;
  services.mako.settings.backgroundColor = "#211e20";
  services.mako.settings.borderColor = "#211e20";
  services.mako.settings.padding = "10,5,10,10";
  services.mako.settings.textColor = "#a0a08b";
}
