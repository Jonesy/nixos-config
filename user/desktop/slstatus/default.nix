{pkgs, ...}: let
  slstatusCustom = pkgs.slstatus.override {
    conf = ./config.h;
  };
in {
  home.packages = [
    slstatusCustom
    # (slstatusCustom.overrideAttrs (oldAttrs: {
    #   src = ./src;
    # }))
  ];
}
