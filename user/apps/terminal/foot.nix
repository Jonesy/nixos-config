{pkgs, ...}: {
  home.packages = [pkgs.foot];
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "IosevkaTerm Nerd Font Mono:size=16";
      };
    };
    # theme = "dracula";
  };
}
