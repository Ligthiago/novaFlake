{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "hyprarrange";
  version = "unstable-2024-02-3";

  src = fetchFromGitHub {
    owner = "Ligthiago";
    repo = "hyprlandScripts";
    rev = "b1e61fdb4400c7060559672474eb7d4f1d80fd45";
    hash = "sha256-3aiZGgsiiHu6kJzLa2C3ej+7siL08tt7yYNmZxfElEE=";
  };

    strictDeps = true;

  makeFlags = [
    "PREFIX=$(out)"
  ];

  installPhase = ''
    make install-hyprarrange PREFIX=$out
    mkdir -p $out/bin
    cp hyprarrange/hyprarrange $out/bin
  '';

  meta = with lib; {
    description = "Workspace rearrangement tool for Hyprland";
    homepage = "https://github.com/Ligthiago/hyprlandScripts/";
    maintainers = with maintainers; [Ligthiago];
    mainProgram = "hyprarrange";
    platforms = platforms.all;
  };
}
