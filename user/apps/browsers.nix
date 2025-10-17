{pkgs, ...}: {
  home.packages = with pkgs; [
    firefox
    librewolf
    floorp-bin
    vivaldi
  ];
}
