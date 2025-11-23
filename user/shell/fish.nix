{...}: {
  programs.fish = {
    enable = true;
    # functions = {
    #   fish_prompt = ''
    #     set -l nix_shell_info (
    #       if test -n "$IN_NIX_SHELL"
    #         echo -n "<nix-shell> "
    #       end
    #     )
    #   '';
    # };
    shellAliases = {
      zj = "zellij";
      lg = "lazygit";
      ll = "eza -l --icons --header";
      lla = "eza -l -a --icons --header";
      nd = "nix develop --command fish";
    };
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      fish_add_path = ~/.npm-packages/bin
    '';
  };
}
