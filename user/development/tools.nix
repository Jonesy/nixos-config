{pkgs, ...}: {
  home.packages = with pkgs; [
    lazygit
    gh
    glab
    gcc
    c3c
    gnumake42
    fzf
    ripgrep
    fd
    htop
    any-nix-shell
    nix-prefetch
    glow
    eza
    bat
    yazi
    zoxide
    just
  ];
}
