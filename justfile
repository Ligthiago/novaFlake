# Update flake inputs

history:
    nix profile history --profile /nix/var/nix/profiles/system

update:
    sudo nix flake update

rebuild input:
    sudo nixos-rebuild switch --flake '.#{{input}}'
    
