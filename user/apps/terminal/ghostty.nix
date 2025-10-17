{pkgs, ...}: {
  home.packages = [pkgs.ghostty];

  programs.ghostty = {
    enable = true;
    settings = {
      background = "#212337";
      theme = "Duckbones";
      font-family = "IosevkaTerm Nerd Font Mono";
      font-size = 16.0;
      clipboard-read = "allow";
      clipboard-write = "allow";
      clipboard-paste-protection = true;
    };
  };
}
