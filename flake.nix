{
  description = "Nova Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    hycov = {
      url = "github:DreamMaoMao/hycov";
      inputs.hyprland.follows = "hyprland";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: let
    lib = inputs.snowfall-lib.mkLib {
      inherit inputs;
      src = ./.;
      snowfall = {
        namespace = "nova";
        meta = {
          name = "Nova";
          title = "Nova Flake";
        };
      };
    };
  in
    lib.mkFlake {
      # Channels configuration
      channels-config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "electron-25.9.0"
        ];
      };

      # Global overlays
      overlays = with inputs; [
        nur.overlay
      ];

      # System-wide configurations
      systems = {
        modules = {
          nixos = with inputs; [
            home-manager.nixosModules.home-manager
          ];
        };
      };

      # User-specific configurations
      homes = {
        users = {
          "ligthiago@prometheus" = {
            modules = with inputs; [
              nixvim.homeManagerModules.nixvim
              ags.homeManagerModules.default
            ];
            specialArgs = {
              home-manager.useGlobalPkgs = true;
            };
          };
          "ligthiago@theseus" = {
            modules = with inputs; [
              nixvim.homeManagerModules.nixvim
              ags.homeManagerModules.default
            ];
            specialArgs = {
              home-manager.useGlobalPkgs = true;
            };
          };
        };
      };

      # Templates for fast initialisation of flake-based projects
      templates = {
        shell = {
          path = ./templates/shell;
          description = "Default shell developmemt template";
          welcomeText = "Development template initialised";
        };
        bun = {
          path = ./templates/bun;
          description = "Default JS/TS development environment with Bun";
          welcomeText = "Development template initialised.";
        };
      };
    };
}
