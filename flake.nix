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

    # Utility helpers
    supportedSystems = ["x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    nixpkgsFor = forAllSystems (system: import nixpkgs {inherit system;});
  in {
    nixosConfigurations = {
      inherit pkgs;
      welshy = lib.nixosSystem {
        modules = [
          ./profiles/office/configuration.nix
          # TODO: Make sure I can build on a per-computer basis, embed home manager as
          # per the docs.
          # home-manager.nixosModules.home-manager
          # {
          #   home-manager.useGlobalPkgs = true;
          #   home-manager.userUserPackages = true;
          #   home-manager.users.jjones = import ./profiles/office/home.nix;
          #   home-manager.extraSpecialArgs = {
          #     inherit pkgs;
          #     inherit userSettings;
          #     inherit inputs;
          #   };
          # }
          # home-manager.nixosModules.home-manager
          # {
          #   inherit pkgs;
          #   modules = [
          #     ./profiles/${systemSettings.profile}/home.nix
          #   ];
          #   extraSpecialArgs = {
          #     inherit userSettings;
          #     inherit inputs;
          #   };
          # }
        ];
      };
    };

    homeConfigurations = {
      "thinkpad" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./profiles/thinkpad/home.nix
        ];
        extraSpecialArgs = {
          inherit userSettings;
          inherit inputs;
        };
      };
      "office" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./profiles/office/home.nix
        ];
        extraSpecialArgs = {
          inherit userSettings;
          inherit inputs;
        };
      };
    };
  };
}
