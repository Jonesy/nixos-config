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
    dwl
    wmenu
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

  home.file = {};

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
