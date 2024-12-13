{pkgs, ...}: {
  home.packages = [pkgs.alacritty];
  programs.alacritty = {
    enable = true;
    settings = {
      terminal = {
        shell = {
          program = "fish";
          args = ["--login"];
        };
      };
    };
  };
}
