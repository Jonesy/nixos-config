{pkgs, ...}: {
  home.packages = [pkgs.ghostty];

  programs.ghostty = {
    enable = true;
    settings = {
      background = "#212337";
      theme = "duckbones";
      font-family = "IosevkaTerm Nerd Font Mono";
    };
  };
}
