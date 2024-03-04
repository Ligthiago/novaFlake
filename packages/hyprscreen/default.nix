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
    rev = "b1e61fdb4400c7060559672474eb7d4f1d80fd45";
    hash = "sha256-3aiZGgsiiHu6kJzLa2C3ej+7siL08tt7yYNmZxfElEE=";
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
    wrapProgram $out/bin/hyprscreen --prefix PATH ':' \
      "${lib.makeBinPath [
      coreutils
      grim
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
