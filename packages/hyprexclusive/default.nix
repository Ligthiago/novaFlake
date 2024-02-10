{
  lib,
  stdenv,
  fetchFromGitHub,
  makeWrapper,
}:
stdenv.mkDerivation rec {
  pname = "hyprexclusive";
  version = "unstable-2024-01-26";

  src = fetchFromGitHub {
    owner = "Ligthiago";
    repo = "hyprlandScripts";
    rev = "d0ee6dd756a9c563ffb30178c14e61ae3a8da941";
    hash = "sha256-wibX6leqqqsmzGAC3R37Tnn0f+nCUp0G7EdUJScwNRM=";
  };

  strictDeps = true;

  nativeBuildInputs = [
    makeWrapper
  ];

  makeFlags = [
    "PREFIX=$(out)"
  ];

  installPhase = ''
    make install-hyprexclusive PREFIX=$out
    mkdir -p $out/bin
    cp hyprexclusive/hyprexclusive $out/bin
  '';

  meta = with lib; {
    description = "Exclusive window helper for Hyprland";
    homepage = "https://github.com/Ligthiago/hyprlandScripts/";
    maintainers = with maintainers; [Ligthiago];
    mainProgram = "hyprexclusive";
    platforms = platforms.all;
  };
}
