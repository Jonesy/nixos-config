{...}: {
  programs.fish = {
    enable = true;
    shellAliases = {
      zj = "zellij";
      lg = "lazygit";
      ll = "eza -l --icons --header";
      lla = "eza -l -a --icons --header";
      nd = "nix develop --command fish";
    };
    interactiveShellInit = ''
      fish_add_path = ~/.npm-packages/bin
    '';
  };
}
