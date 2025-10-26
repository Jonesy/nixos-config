{pkgs, ...}: {
  programs.dwl = {
    enable = true;
    package =
      (pkgs.dwl.override {
        configH = ./config.h;
      }).overrideAttrs (oldAttrs: {
        src = ./src;
        buildInputs =
          oldAttrs.buildInputs or []
          ++ [
            pkgs.wlroots_0_19
            pkgs.libdrm
            pkgs.fcft
            pkgs.pixman
          ];
      });
  };
}
