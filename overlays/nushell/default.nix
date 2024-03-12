_:_final:
prev: {
  nushell = prev.nushell.overrideAttrs (old: rec {
    # version = "0.90.1";
    # src = prev.fetchFromGitHub {
    #   owner = "nushell";
    #   repo = "nushell";
    #   rev = "0.90.1";
    #   hash = "sha256-MODd2BT2g6g5H6/1EG5OjIoYm18yBSvYTR83RuYDMec=";
    # };
    # cargoDeps = prev.rustPlatform.importCargoLock {
    #   lockFile = "${src}/Cargo.lock";
    # };
  });
}
