{
  description = "Jonesy's NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    _1password-shell-plugins.url = "github:1Password/shell-plugins";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
    userSettings = rec {
      username = "jjones";
      fullName = "Joshua Jones";
      email = "joshua@general-metrics.com";
      terminal = "alacritty";
      fontFamilyTerm = "IosevkaTerm Nerd Font";
      fontFamilyGui = "SpaceMono Nerd Font";
      fontSize = 16.0;
    };

    systemSettings = {
      # TODO: See if I can have this set dynamically out of source control at runtime.
      profile = "office";
    };

    # Utility helpers
    supportedSystems = ["x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    nixpkgsFor = forAllSystems (system: import nixpkgs {inherit system;});
  in {
    nixosConfigurations = {
      inherit pkgs;
      welshy = lib.nixosSystem {
        modules = [./profiles/office/configuration.nix];
      };
    };

    homeConfigurations."jjones" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./profiles/${systemSettings.profile}/home.nix
      ];
      extraSpecialArgs = {
        inherit userSettings;
        inherit inputs;
      };
    };
  };
}
