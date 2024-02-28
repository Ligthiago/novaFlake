{
  description = "Nova Flake";

  inputs = {
    # Nix Packages collection (unstable)
    # Source: https://github.com/NixOS/nixpkgs
    # Documentation: https://nixos.org/manual/nixpkgs/unstable/
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    # Home Manager provides a basic system for managing a user environment.
    # It allows declarative configuration of user specific (non-global) packages and dotfiles.
    # Source: https://github.com/nix-community/home-manager
    # Documentation: https://nix-community.github.io/home-manager/
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Snowfall Lib is a library that makes it easy to manage Nix flake by imposing an opinionated file structure.
    # Source: https://github.com/snowfallorg/lib
    # Documentation: https://snowfall.org/reference/lib/
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixos-generators allows to take the same NixOS configuration, and generate outputs for different target formats.
    # Source: https://github.com/nix-community/nixos-generators
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix User Repository (NUR) is a community-driven meta repository for Nix packages.
    # Source: https://github.com/nix-community/NUR
    # Documentation: https://nur.nix-community.org/documentation/
    nur = {
      url = "github:nix-community/NUR";
    };

    # NixVim is a Neovim distribution built around Nix modules.
    # Source: https://github.com/nix-community/nixvim
    # Documentation: https://nix-community.github.io/nixvim/
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland is a dynamic tiling Wayland compositor based on wlroots
    # Source: https://github.com/hyprwm/Hyprland
    # Documentation: https://wiki.hyprland.org/
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    # Hycov is a hyprland overview mode plugin.
    # Source: https://github.com/DreamMaoMao/hycov
    hycov = {
      url = "github:DreamMaoMao/hycov";
      inputs.hyprland.follows = "hyprland";
    };

    # Hyprkeys is a keybind inspection utility for Hyprland
    # Source: https://github.com/hyprland-community/Hyprkeys
    hyprkeys = {
      url = "github:hyprland-community/hyprkeys";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Ags is a library built for GJS to allow defining GTK widgets in a declarative way.
    # Source: https://github.com/Aylur/ags
    # Documentation: https://aylur.github.io/ags-docs/
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
      channels-config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "electron-25.9.0"
        ];
      };

      overlays = with inputs; [
        nur.overlay
      ];

      systems = {
        modules = {
          nixos = with inputs; [
            home-manager.nixosModules.home-manager
          ];
        };
      };

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
