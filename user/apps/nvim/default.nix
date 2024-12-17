# This file is in charge of any NeoVim plugins or LSPs, etc
{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim
    # NeoVim required
    tree-sitter
    nodejs_20

    # LSPs
    bash-language-server
    emmet-language-server
    gopls
    lua-language-server
    rust-analyzer
    marksman
    nixd
    nodePackages_latest.typescript-language-server
    templ
    vscode-langservers-extracted
    zls

    # Linters
    lua54Packages.luacheck

    # Formatters
    stylua
    alejandra
    shellharden
  ];
}
