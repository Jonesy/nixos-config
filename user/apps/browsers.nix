{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    firefox
    floorp-bin
    vivaldi
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
