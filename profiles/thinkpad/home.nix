# ThinkPad Dotfiles
{
  pkgs,
  userSettings,
  ...
}: {
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

  home.packages = with pkgs; [
    # Window Manager
    wl-clipboard
    shotman
    devenv
    brightnessctl
  ];

  programs.waybar.settings.mainBar = let
    waybarSettings = import ../../user/desktop/waybar;
    existingModules = waybarSettings.settings.mainBar.modules-right or [];
  in {
    output = ["eDP-1"];
    battery = {
      format = "<span color='#555568'>{icon}</span> {capacity}%";
      format-charging = "<span color='#555568'>󰂄 </span> {capacity}%";
      format-icons = ["󰁺" "󰁼" "󰁿" "󰂁" "󰁹"];
    };
    modules-right = existingModules ++ ["battery"];
  };
  wayland.windowManager.sway.config.output = {
    "Virtual-1" = {
      mode = "1920x1080@60Hz";
      adaptive_sync = "on";
    };
  };

  fonts.fontconfig.enable = true;

  home.file.".local/bin/start-dwl" = let
    dbusActivate = "${pkgs.dbus}/bin/dbus-update-activation-environment";
  in {
    executable = true;
    text = ''
      #!/bin/sh
      # Kill already running services
      pkill -9 -x waybar mako swaybg swayidle

      # Required for starting from at TTY
      export XDG_CURRENT_DESKTOP=wlroots
      export XDG_SESSION_TYPE=wayland
      export XDG_SESSION_DESKTOP=wlroots

      # Tell dwl about dbus
      ${dbusActivate} --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
      systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      echo "imported WAYLAND_DISPLAY=$WAYLAND_DISPLAY pid=$$" >> /tmp/dwl-start.log

      waybar &
      mako &
      swaybg --image /home/jjones/.dotfiles/wallpaper.jpg --output \"*\" &
      foot --server &
      swayidle -w \
          timeout 300 '${pkgs.waylock}/bin/waylock -c 000000' \
          timeout 360 '${pkgs.wlopm}/bin/wlopm --off "*"' \
          resume '${pkgs.wlopm}/bin/wlopm --on "*"' \
          timeout 600 '${pkgs.systemd}/bin/systemctl suspend' \
          before-sleep '${pkgs.waylock}/bin/waylock -c 000000' &
      wait
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
