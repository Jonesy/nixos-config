# ThinkPad Dotfiles
{
  pkgs,
  userSettings,
  ...
}: let
  dwlbCustom = pkgs.dwlb.override {
    configH = ../../user/desktop/dwlb/config.h;
  };
in {
  home.username = userSettings.username;
  home.homeDirectory = "/home/jjones";

  # userSettings.display = display;

  imports = [
    ../../user/apps/git/git.nix
    ../../user/development
    ../../user/shell
    ../../user/apps/terminal
    ../../user/desktop
    ../../user/apps/network.nix
    ../../user/apps/1password.nix
    ../../user/apps/nvim
    ../../user/security/ssh.nix
    ../../user/apps/browsers.nix
    ../../user/apps/chat.nix
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = [
    dwlbCustom
    # Window Manager
    pkgs.wl-clipboard
    pkgs.shotman
    pkgs.devenv
    pkgs.brightnessctl
  ];

  fonts.fontconfig.enable = true;

  home.file.".local/bin/display-bar" = {
    executable = true;
    text = ''
      #!/bin/sh
      ${dwlbCustom}/bin/dwlb -ipc -status all "$(display_brightness)  $(display_volume)  $(display_wifi)  $(display_cpu)  $(display_battery)  $(date '+%b %d %I:%M')"
    '';
  };

  home.file.".local/bin/start-dwl" = let
    dbusActivate = "${pkgs.dbus}/bin/dbus-update-activation-environment";
  in {
    executable = true;
    text = ''
      #!/bin/sh
      # Required for starting from at TTY
      export XDG_CURRENT_DESKTOP=wlroots
      export XDG_SESSION_TYPE=wayland
      export XDG_SESSION_DESKTOP=wlroots

      # Kill already running services
      pkill -x mako swaybg swayidle dwlb 2>/dev/null || true

      # Tell dwl about dbus
      ${dbusActivate} --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
      ${dbusActivate} --systemd --all
      ${pkgs.systemd}/bin/systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

      ${pkgs.mako}/bin/mako &
      ${pkgs.swaybg}/bin/swaybg --image /home/jjones/.dotfiles/wallpaper.jpg --output \"*\" &
      ${pkgs.foot}/bin/foot --server &
      ${pkgs.swayidle}/bin/swayidle -w \
          timeout 300 '${pkgs.waylock}/bin/waylock -c 000000' \
          timeout 360 '${pkgs.wlopm}/bin/wlopm --off "*"' \
          resume '${pkgs.wlopm}/bin/wlopm --on "*"' \
          timeout 600 '${pkgs.systemd}/bin/systemctl suspend' \
          before-sleep '${pkgs.waylock}/bin/waylock -c 000000' &
      ${dwlbCustom}/bin/dwlb -ipc &
      while true; do
          ~/.local/bin/display-bar
          sleep 5
      done
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
