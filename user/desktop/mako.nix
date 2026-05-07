# Notifications Daemon
{pkgs, ...}: {
  home.packages = [pkgs.mako];
  services.mako.enable = true;
  services.mako.settings.default-timeout = 5000;
  services.mako.settings.background-color = "#211e20";
  services.mako.settings.border-color = "#211e20";
  services.mako.settings.padding = "10,5,10,10";
  services.mako.settings.text-color = "#a0a08b";
}
