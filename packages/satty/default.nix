{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  wrapGAppsHook4,
  gdk-pixbuf,
  glib,
  gtk4,
  libadwaita,
  copyDesktopItems,
  installShellFiles,
  libepoxy,
}:
rustPlatform.buildRustPackage rec {
  pname = "satty";
  version = "0.11.0";

  src = fetchFromGitHub {
    owner = "gabm";
    repo = "Satty";
    rev = "v${version}";
    hash = "sha256-LKVm2+lWGNuSu9Rcxj6EbKYClCzeaxB96cJ+qgfjLZI=";
  };

  cargoHash = "sha256-Uvc8eS65JfZw3kIcm78ToLAUI6c4l38mv3ob5WYxIMw=";

  nativeBuildInputs = [
    copyDesktopItems
    pkg-config
    wrapGAppsHook4
    installShellFiles
  ];

  buildInputs = [
    gdk-pixbuf
    glib
    gtk4
    libadwaita
    libepoxy
  ];

  postInstall = ''
    install -Dt $out/share/icons/hicolor/scalable/apps/ assets/satty.svg

    installShellCompletion --cmd satty \
      --bash completions/satty.bash \
      --fish completions/satty.fish \
      --zsh completions/_satty
  '';

  desktopItems = ["satty.desktop"];

  meta = with lib; {
    description = "A screenshot annotation tool inspired by Swappy and Flameshot";
    homepage = "https://github.com/gabm/Satty";
    license = licenses.mpl20;
    maintainers = with maintainers; [pinpox donovanglover];
    mainProgram = "satty";
    platforms = lib.platforms.linux;
  };
}
