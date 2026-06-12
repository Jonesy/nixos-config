{pkgs, ...}: let
  someblocks = pkgs.stdenv.mkDerivation {
    pname = "someblocks";
    version = "git";

    src = pkgs.fetchFromSourcehut {
      owner = "~raphi";
      repo = "someblocks";
      rev = "master";
      hash = "sha256-L+O6vq+cSPvxDDNiwNqRJCSrtsbiQ7SUw//HXkaZF88=";
    };

    postPatch = ''
      cp ${./blocks.h} blocks.h
    '';

    nativeBuildInputs = [pkgs.pkg-config];
    buildInputs = [pkgs.wayland];

    installPhase = ''
      mkdir -p $out/bin
      cp someblocks $out/bin/
    '';
  };
in {
  home.packages = [
    someblocks
  ];
}
