{
  description = "Home Manager configuration of jjones";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      userSettings = rec {
        username = "jjones";
        email = "joshua@general-metrics.com";
        fullName = "Joshua Jones";
        fontFamilyTerm = "IosevkaTerm Nerd Font";
      };
    in
    {
      nixosConfigurations = {
        inherit pkgs;
        nixos = lib.nixosSystem {
          modules = [ ./configuration.nix ];
        };
      };
      homeConfigurations."jjones" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        extraSpecialArgs = {
          inherit userSettings;
        };
      };
    };
}
