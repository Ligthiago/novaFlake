<div align="center">
    <img alt="Nova Flake" src="assets/logo.png" width="200px"/>
    <h1> Nova Flake </h1>
</div>

This is my personal NixOS configuration, built with Snowfall Lib and Home Manager. Nothing special.

## Structure

```sh
# Root directory of the flake
.
# Entry point of the flake
├── flake.nix
# Locked dependencies
├── flake.lock
# Assets directory contains media files, such as logos and other images.
├── assets
│  └── logo.png
# Homes directory contains home-manager configurations
├── homes
│  └── x86_64-linux
│     └── host@username
│        └── default.nix
# Lib directory contains internal libraries 
├── lib
│  └── helpers
│     └── default.nix
# Modules directory contains modules for nixos and home-manager
├── modules
│  ├── home
│  │  │  # Applications (Interactive applications, GUI or TUI)
│  │  ├── applications
│  │  │  └── app-name
│  │  │     └── default.nix
│  │  │  # Compositors, launchers and widgets
│  │  ├── environments
│  │  │  ├── env-name
│  │  │  │  └── default.nix
│  │  │  └── parts
│  │  │     └── part-name
│  │  │        └── default.nix
│  │  │  # Services and daemons
│  │  ├── services
│  │  │  └── service-name
│  │  │     └── default.nix
│  │  │  # Command shells and related software
│  │  ├── shells
│  │  │  ├── shell-name
│  │  │  │  └── default.nix
│  │  │  └── parts
│  │  │     └── program-name
│  │  │        └── default.nix
│  │  │   # CLI tools
│  │  └── tools
│  │     └── program-name
│  │        └── default.nix
│  └── nixos
│     │  # Hardware modules, such as sound and printing
│     ├── hardware
│     │  └── category-name
│     │     └── default.nix
│     │  # Services and daemons
│     └── services
│        └── service-name
│           └── default.nix
│   # Overlays directory contains custom overlays
├── overlays
│   # Overlays directory contains custom packages
├── packages
│  # Systems directory contains nixos configurations
└── systems
   └── x86_64-linux
      └── host
         ├── default.nix
         └── hardware.nix
```
