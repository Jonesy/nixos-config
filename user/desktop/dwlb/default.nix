{pkgs, ...}: let
  dwlbCustom = pkgs.dwlb.override {
    configH = ./config.h;
  };
in {
  home.packages = [
    dwlbCustom
  ];
}
#   dwlb = pkgs.stdenv.mkDerivation {
#     pname = "dwlb";
#     version = "git";
#     src = pkgs.fetchFromGitHub {
#       owner = "kolunmi";
#       repo = "dwlb";
#       rev = "main";
#       hash = "sha256-S0jkoELkF+oEmXqiWZ8KJYtWAHEXR/Y93jl5yHgUuSM=";
#     };
#
#     postPatch = ''
#       cp ${./config.h} config.h
#     '';
#
#     nativeBuildInputs = with pkgs; [
#       pkg-config
#       wayland-scanner
#     ];
#
#     buildInputs = with pkgs; [
#       wayland
#       wayland-protocols
#       pixman
#       fcft
#     ];
#
#     makeFlags = ["PREFIX=$(out)"];
#
#     preBuild = ''
#       make clean
#     '';
#   };
# in {
#   home.packages = [
#     dwlb
#   ];
# }

