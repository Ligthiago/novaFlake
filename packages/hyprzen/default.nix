{
  lib,
  stdenv,
  fetchFromGitHub,
  makeWrapper,
}:
stdenv.mkDerivation rec {
  pname = "hyprzen";
  version = "unstable-2024-01-26";

  src = fetchFromGitHub {
    owner = "Ligthiago";
    repo = "hyprlandScripts";
    rev = "d0ee6dd756a9c563ffb30178c14e61ae3a8da941";
    hash = "sha256-wibX6leqqqsmzGAC3R37Tnn0f+nCUp0G7EdUJScwNRM=";
  };

  strictDeps = true;

  makeFlags = [
    "PREFIX=$(out)"
  ];

  installPhase = ''
    make install-hyprzen PREFIX=$out
    mkdir -p $out/bin
    cp hyprzen/hyprzen $out/bin
  '';

  meta = with lib; {
    description = "Zen mode helper for Hyprland.";
    homepage = "https://github.com/Ligthiago/hyprlandScripts/";
    maintainers = with maintainers; [Ligthiago];
    mainProgram = "hyprzen";
    platforms = platforms.all;
  };
}
