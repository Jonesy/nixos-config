# ThinkPad Dotfiles
{pkgs, ...}: {
  home.username = "jjones";
  home.homeDirectory = "/home/jjones";

  imports = [
    ../../user/apps/git/git.nix
    ../../user/development/tools.nix
    ../../user/shell
    ../../user/apps/terminal/alacritty.nix
    ../../user/desktop
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
  ];

  fonts.fontconfig.enable = true;

  home.file = {};

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
