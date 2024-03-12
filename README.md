<div align="center">
    <img alt="Nova Flake" src="assets/logo.png" width="200px"/>
    <h1> Nova Flake </h1>
</div>

This is my personal NixOS configuration, built with Snowfall Lib and Home Manager. Nothing special.

## Structure

The structure of this flake is largely defined by [Snowfall lib](https://github.com/snowfallorg/lib), as this library imposes an opinionated file structure to make flake easy to develop and maintain. It's define directory names and layout, and automatically wiring everything together, allowing to focus on building, not writing boilerplate code.

<details close>
<summary>Expand to see flake scheme</summary>

```sh
.                                 # Root directory of the flake
├── flake.nix                     # Flake entry point with all necessary inputs
├── flake.lock                    # Locked dependencies
├── justfile                      # Project-specific commands
├── assets                        # Assets directory contains media files, such as logos and other images.
│  └── logo.png
├── homes                         # Homes directory contains home-manager configurations
│  └── x86_64-linux               # Architecture directory contains systems with the same target architecture
│     └── host@username           # Home directory per every host and user
│        └── default.nix
├── lib                           # Lib directory contains internal libraries 
│  └── helpers
│     └── default.nix
├── modules                       # Modules directory contains modules for nixos and home-manager
│  ├── home                       # Home directory contains user specific modules
│  │  ├── applications            # Applications directory contains interactive applications modules, GUI or TUI
│  │  │  └── app
│  │  │     └── default.nix
│  │  ├── environments            # Environments directory contains compositors, launchers and widgets modules
│  │  │  ├── env-name
│  │  │  │  └── default.nix
│  │  │  └── parts
│  │  │     └── part
│  │  │        └── default.nix
│  │  ├── services                # Services directory contains services and daemons modules
│  │  │  └── service
│  │  │     └── default.nix
│  │  ├── shells                  # Shells directory contains sommand shells and related software modules
│  │  │  ├── shell
│  │  │  │  └── default.nix
│  │  │  └── parts
│  │  │     └── part
│  │  │        └── default.nix
│  │  └── tools                   # Tools directory contains CLI tools modules
│  │     └── program
│  │        └── default.nix
│  └── nixos                      # Home directory contains system-wide modules
│     ├── hardware                # Hardware directory contains hardware modules, such as sound and printing
│     │  └── category
│     │     └── default.nix
│     └── services                # Services directory contains services and daemons modules
│        └── service
│           └── default.nix
├── overlays                      # Overlays directory contains overlays
├── packages                      # Packages directory contains internal packages
├── shells                        # Shells directory contains development shells
├── systems                       # Systems directory contains system-wide configurations
│  └── x86_64-linux               # Architecture directory contains systems with the same target architecture
│     └── host                    # Host directory, one per system
│        ├── default.nix
│        └── hardware.nix
└── templates                     # Templates directory contains templates for fast flake initialisation
```

</details>

See [Snowfall lib reference](https://snowfall.org/reference/lib/#flake-structure) for more information.