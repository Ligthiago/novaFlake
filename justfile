# View generation history
history:
    nix profile history --profile /nix/var/nix/profiles/system

# Update flake inputs
update:
    sudo nix flake update

# Build and activate the new configuration.
rebuild input:
    sudo nixos-rebuild switch --flake '.#{{input}}'
    