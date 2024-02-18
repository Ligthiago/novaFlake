# View generation history
history:
    nix profile history --profile /nix/var/nix/profiles/system

# Update flake inputs
update:
    sudo nix flake update

# Build and activate the new configuration.
rebuild input:
    sudo nixos-rebuild switch --flake '.#{{input}}'

# Soft garbage-collection (only old generations)
gc-soft:
    sudo nix-collect-garbage --delete-older-than 7d && \
    nix-collect-garbage --delete-older-than 7d

# Hard garbage-collection (all generations except current)
gc-hard:
    sudo nix-collect-garbage -d && \
    nix-collect-garbage -d
    