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
    repo = "hyprscreen";
    rev = "00f41a6629b22ef9abae5526f37ebd02c8ba3c6e";
    hash = "sha256-qMWCM2N1W0RNxg7Cd+wDCrjgOiBgdVPO/tiyqBv95Y0=";
  };
  strictDeps = true;

  nativeBuildInputs = [
    makeWrapper
  ];

  makeFlags = [
    "PREFIX=$(out)"
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp hyprscreen $out/bin
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
