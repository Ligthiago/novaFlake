{
  lib,
  buildGoModule,
  fetchFromGitHub,
  installShellFiles,
}:
buildGoModule rec {
  pname = "tdl";
  version = "0.16.0";

  src = fetchFromGitHub {
    owner = "iyear";
    repo = "tdl";
    rev = "v${version}";
    hash = "sha256-Myf10+Y7lyJFhiRpJFkXe5Rng0ChzOm0EGvPEuFMYp4=";
  };

  vendorHash = "sha256-n3AISS4/yujTNqgGjeEK2eWw0YI1XUafZP36yD+axN4=";

  nativeBuildInputs = [installShellFiles];

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/iyear/tdl/pkg/consts.Version=${version}"
  ];

  # Requires network access
  doCheck = false;

  postInstall = ''
    installShellCompletion --cmd tdl \
      --bash <($out/bin/tdl completion bash) \
      --fish <($out/bin/tdl completion fish) \
      --zsh <($out/bin/tdl completion zsh)
  '';

  meta = with lib; {
    description = "A Telegram downloader/tools written in Golang";
    homepage = "https://github.com/iyear/tdl";
    changelog = "https://github.com/iyear/tdl/releases/tag/v${version}";
    license = licenses.agpl3Only;
    maintainers = with maintainers; [Ligthiago];
    mainProgram = "tdl";
  };
}
