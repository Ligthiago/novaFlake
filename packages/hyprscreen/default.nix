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
    rev = "b1964d52dd676d7002f30a428388368529a50b67";
    hash = "sha256-1HKpwJYM7QtL/TYWsSxxr332Yy07MmdOSMtkZuJdRTo=";
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
