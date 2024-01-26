{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "hyprzen";
  version = "unstable-2024-01-26";

  src = fetchFromGitHub {
  owner = "Ligthiago";
  repo = "hyprlandScripts";
  rev = "e89d54207e27124c810f2cd8226e6f87cd7027a6";
  hash = "sha256-eDAG3GK7jeroGNoTehGSai9eq8wKD8hvliXyYdm/er8=";
};
  sourceRoot = "${src.name}/hyprzen";

  installPhase = ''
    mkdir -p $out/bin
    cp hyprzen $out/bin
  '';

  meta = with lib; {
    description = "Zen mode helper for Hyprland.";
    homepage = "https://github.com/Ligthiago/hyprlandScripts/";
    maintainers = with maintainers; ["Ligthiago"];
    mainProgram = "hyprzen";
    platforms = platforms.all;
  };
}
