{ pkgs, ... }:
{
  home.packages = with pkgs; [ zellij ];
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      default_layout = "compact";
      default_shell = "fish";
      simplified_ui = true;
      copy_command = "xclip -selection clipboard";
      theme = "custom";
      themes.custom.fg = "#D8DEE9";
      themes.custom.bg = "#2E3440";
      themes.custom.black = "#3B4252";
      themes.custom.red = "#BF616A";
      themes.custom.green = "#A3BE8C";
      themes.custom.yellow = "#EBCB8B";
      themes.custom.blue = "#81A1C1";
      themes.custom.magenta = "#B48EAD";
      themes.custom.cyan = "#88C0D0";
      themes.custom.white = "#E5E9F0";
      themes.custom.orange = "#D08770";
    };
  };
}
