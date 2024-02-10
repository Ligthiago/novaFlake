{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  makeWrapper,
  coreutils,
  grim,
  slurp,
  hyprland,
  hyprpicker,
  jq,
  libnotify,
  wl-clipboard,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "hyprscreen";
  version = "unstable-2024-02-9";

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
    make install-hyprscreen PREFIX=$out
    mkdir -p $out/bin
    cp hyprscreen/hyprscreen $out/bin
  '';

  postInstall = ''
    wrapProgram $out/bin/grimblast --prefix PATH ':' \
      "${lib.makeBinPath [
      coreutils
      grim
      hyprland
      hyprpicker
      jq
      libnotify
      slurp
      wl-clipboard
    ]}"
  '';

  meta = with lib; {
    description = "Screenshot helper for Hyprland.";
    homepage = "https://github.com/Ligthiago/hyprlandScripts/";
    platforms = platforms.unix;
    maintainers = with maintainers; [Ligthiago];
    mainProgram = "hyprscreen";
  };
})
