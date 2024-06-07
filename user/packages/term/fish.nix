{ pkgs, ... }:
{
  home.packages = with pkgs; [ starship ];
  # See reference here: https://nixos.wiki/wiki/Fish
  programs.fish = {
    enable = true;
    shellAliases = {
      zj = "zellij";
      lg = "lazygit";
      ll = "eza -l --icons --header";
      lla = "eza -l -a --icons --header";
      cl = "clear";
      nd = "nix develop --command fish";
    };
    interactiveShellInit = ''
      fish_add_path = ~/.npm-packages/bin
    '';
  };

  programs.starship = {
    enable = true;
  };
}
