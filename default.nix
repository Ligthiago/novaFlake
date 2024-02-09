{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "hyprscreen";
  version = "unstable-2024-02-09";

  src = fetchFromGitHub {
    owner = "Ligthiago";
    repo = "hyprscreen";
    rev = "1a19851f6095205f5c41d22c861af1191e6e8fad";
    hash = "sha256-oyCPIFnFR8d7Bue5AWMiwJSyJFe22uBzh5p5CLeCy8A=";
  };

  meta = with lib; {
    description = "Screenshot tool for Hyprland";
    homepage = "https://github.com/Ligthiago/hyprscreen";
    license = licenses.unfree; # FIXME: nix-init did not found a license
    maintainers = with maintainers; [];
    mainProgram = "hyprscreen";
    platforms = platforms.all;
  };
}
