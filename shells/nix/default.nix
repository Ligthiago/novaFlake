{pkgs, ...}:
pkgs.mkShell {
  name = "nix-dev";
  packages = with pkgs; [
    deadnix
    dconf2nix
    nurl
    nix-init
  ];
  shellHook = ''
    echo "Available tools: deadnix, dconf2nix, nurl, nix-init"
  '';
}
