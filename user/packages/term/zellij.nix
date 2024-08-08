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
      themes.custom.fg = "#ebfafa";
      themes.custom.bg = "#212337";
      themes.custom.black = "#323449";
      themes.custom.red = "#f16c75";
      themes.custom.green = "#37f499";
      themes.custom.yellow = "#f1fc79";
      themes.custom.blue = "#a48cf2";
      themes.custom.magenta = "#a48cf2";
      themes.custom.cyan = "#04d1f9";
      themes.custom.white = "#ebfafa";
      themes.custom.orange = "#f7c67f";
    };
  };
}
