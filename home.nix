{ config, pkgs, ... }:

{
  home.username = "jjones";
  home.homeDirectory = "/home/jjones";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    firefox
    thunderbird
    signal-desktop

    # dev tools
    alacritty
    kitty
    zellij
    gh
    lazygit
    _1password
    _1password-gui
    eza

    # NEOVIM
    neovim
    tree-sitter
    git
    nodejs_20
    gcc
    ripgrep
    fd
    xclip

    # LSPs
    nil
    gopls
    lua-language-server
    rust-analyzer
    nodePackages_latest.typescript-language-server
    zls

    # Linters
    lua54Packages.luacheck

    # Formatters
    stylua
    prettierd
    nixpkgs-fmt
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.stateVersion = "23.05"; # Did you read the comment?

  programs.git = {
    enable = true;
    userName = "Joshua Jones";
    userEmail = "joshua@general-metrics.com";
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "BlexMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "BlexMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "BlexMono Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "BlexMono Nerd Font";
          style = "Bold Italic";
        };
        size = 16;
      };
    };
  };

  programs.zellij = {
    enable = true;
    settings = {
      default_layout = "compact";
      theme = "catppuccin-mocha";
    };
  };

}
