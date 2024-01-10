{pkgs, ...}:
pkgs.mkShell {
  packages = with pkgs; [
    deadnix
    dconf2nix
    alejandra
  ];
  shellHook = ''
    echo ""
    echo "Nix-flake development environment"
    echo ""
    echo "Tools available:"
    echo "Alejandra: format Nix code"
    echo "Deadnix: search for dead code"
    echo "Dconf2nix: convert dconf files to Nix"
    echo ""
  '';
}
