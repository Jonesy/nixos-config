{pkgs, ...}: {
  home.packages = with pkgs; [
    firefox
    librewolf
    floorp
    vivaldi
  ];
}
