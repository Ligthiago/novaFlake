{
  lib,
  python3,
  fetchFromGitHub,
}:
python3.pkgs.buildPythonApplication rec {
  pname = "smassh";
  version = "3.0.4";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "kraanzu";
    repo = "smassh";
    rev = "v${version}";
    hash = "sha256-Jon8B8pTuWxm/pERdYhkI1tWALPaq8EI1v8h8kX/4vg=";
  };

  nativeBuildInputs = [
    python3.pkgs.poetry-core
  ];

  propagatedBuildInputs = with python3.pkgs; [
    appdirs
    click
    requests
    textual
  ];

  pythonImportsCheck = ["smassh"];

  meta = with lib; {
    description = "Smassh your Keyboard, TUI Edition";
    homepage = "https://github.com/kraanzu/smassh";
    changelog = "https://github.com/kraanzu/smassh/blob/${src.rev}/CHANGELOG.md";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [Ligthiago];
    mainProgram = "smassh";
  };
}
