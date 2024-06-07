{ pkgs, ... }:
{
  home.packages = with pkgs; [ zellij ];
  programs.zellij = {
    enable = true;
    settings = {
      default_layout = "compact";
      default_shell = "fish";
      theme = "catpupuccin-mocha";
      copy_command = "xclip -selection clipboard";
    };
  };
}
