{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "s";
  version = "0.6.9";

  src = fetchFromGitHub {
    owner = "zquestz";
    repo = "s";
    rev = "v${version}";
    hash = "sha256-CBqDA/fH18MKDf6WL9Jz4ajQ+1UuHT3zh3Pun+vxz5c=";
  };

  vendorHash = "sha256-0aban/2Gn85mE5sv97uPDuH7OhOHpcFmHGiYaOMUyks=";

  ldflags = ["-s" "-w"];

  meta = with lib; {
    description = "Open a web search in your terminal";
    homepage = "https://github.com/zquestz/s";
    license = licenses.mit;
    maintainers = with maintainers; [Ligthiago];
    mainProgram = "s";
  };
}
