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
      colors = {
        # Default colors
        primary = {
          background = "#212337";
          foreground = "#ebfafa";
        };

        # Normal colors
        normal = {
          black = "#323449";
          red = "#f16c75";
          green = "#37f499";
          yellow = "#f1fc79";
          blue = "#7081d0";
          magenta = "#a48cf2";
          cyan = "#04d1f9";
          white = "#ebfafa";
        };

        # Bright colors
        bright = {
          black = "#323449";
          red = "#f16c75";
          green = "#37f499";
          yellow = "#f1fc79";
          blue = "#7081d0";
          magenta = "#a48cf2";
          cyan = "#04d1f9";
          white = "#ebfafa";
        };
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
    };
  };
}
