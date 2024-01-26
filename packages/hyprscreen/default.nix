{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "hyprscreen";
  version = "unstable-2024-01-22";

  src = fetchFromGitHub {
    owner = "Ligthiago";
    repo = "hyprlandScripts";
    rev = "b681b1799954bbdd40d02c3cc1738c1cdf154c49";
    hash = "sha256-a65f5oGf4C3jZgmN2uYXvIzrqzXGmRU4+uykX4dZyMA=";
  };

  sourceRoot = "${src.name}/hyprscreen";

  installPhase = ''
    mkdir -p $out/bin
    cp hyprscreen $out/bin
  '';

  meta = with lib; {
    description = "Screenshot helper for Hyprland.";
    homepage = "https://github.com/Ligthiago/hyprlandScripts/";
    maintainers = with maintainers; ["Ligthiago"];
    mainProgram = "hyprscreen";
    platforms = platforms.all;
  };
}
