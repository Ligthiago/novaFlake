{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "tdl";
  version = "0.15.1";

  src = fetchFromGitHub {
    owner = "iyear";
    repo = "tdl";
    rev = "v${version}";
    hash = "sha256-vKcKHxPwF7kdsEASJ4VunPZ9kVztPq3yH8RnCd9uI9A=";
  };

  vendorHash = "sha256-v5okd7PAnA2JsgZ4SqvpZmXOQXSCzl+SwFx9NWo7C/0=";

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/iyear/tdl/pkg/consts.Version=${version}"
  ];
  
  doCheck = false;

  meta = with lib; {
    description = "A Telegram downloader/tools written in Golang";
    homepage = "https://github.com/iyear/tdl";
    license = licenses.agpl3Only;
    platforms = platforms.all;
    maintainers = with maintainers; [Ligthiago];
  };
}
