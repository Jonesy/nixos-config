{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-control-center
    blueman
  ];

  services = {
    blueman-applet.enable = true;
  };
}
