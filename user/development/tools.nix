{pkgs, ...}: {
  home.packages = with pkgs; [
    nushell
    lazygit
    gh
    glab
    gcc
    # c3c
    bc
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
    panache
  ];
}
