{
  config,
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;

    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      bars = [];
      startup = [
        {command = lib.getExe' config.services.mako.package "mako";}
        {
          command = "swaybg --image ${config.home.homeDirectory}/.dotfiles/wallpaper.jpg --output \"*\"";
        }
        {
          command = "systemctl --user restart waybar";
          always = true;
        }
      ];
      keybindings = let
        mod = config.wayland.windowManager.sway.config.modifier;
        pamixer = lib.getExe pkgs.pamixer;
        wofi = lib.getExe pkgs.wofi;
      in
        lib.mkOptionDefault {
          "${mod}+space" = "exec ${wofi} --show run --prompt=Run";
          "XF86AudioRaiseVolume" = "exec ${pamixer} --increase 5";
          "XF86AudioLowerVolume" = "exec ${pamixer} --decrease 5";
          "XF86AudioMute" = "exec ${pamixer} --toggle-mute";
          "XF86AudioMicMute" = "exec ${pamixer} --default-source --toggle-mute";
        };
      output = {
        "Virtual-1" = {
          mode = "3840x2161@60Hz";
        };
      };
      fonts = {
        size = 14.0;
      };
      assigns = {
        "1: Terminal" = [{class = "^Alacritty$";}];
        "10: Slack" = [{class = "^Slack$";}];
      };
      colors = let
        main = "#211e20";
        secondary = "#555568";
        light = "#a0a08b";
        dark = "#e9efec";
      in {
        focused = {
          background = secondary;
          border = secondary;
          childBorder = secondary;
          text = dark;
          indicator = dark;
        };
        unfocused = {
          background = main;
          border = secondary;
          childBorder = dark;
          text = light;
          indicator = main;
        };
        focusedInactive = {
          background = main;
          border = secondary;
          childBorder = dark;
          text = light;
          indicator = main;
        };
      };
    };
    extraConfig = ''
      output * scale 2
    '';
  };
}
