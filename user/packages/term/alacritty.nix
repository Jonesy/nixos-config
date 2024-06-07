{ pkgs, userSettings, ... }:
{
  home.packages = with pkgs; [ alacritty ];
  programs.alacritty = {
    enable = true;
    settings = {
      shell = {
        program = "fish";
        args = [ "--login" ];
      };
      font = {
        normal = {
          family = userSettings.fontFamilyTerm;
          style = "Regular";
        };
        bold = {
          family = userSettings.fontFamilyTerm;
          style = "Bold";
        };
        italic = {
          family = userSettings.fontFamilyTerm;
          style = "Italic";
        };
        bold_italic = {
          family = userSettings.fontFamilyTerm;
          style = "Bold Italic";
        };
        size = 16;
      };
      # TODO: Get my old MacOS CMD+K -> clear keybinding
    };
  };
}
