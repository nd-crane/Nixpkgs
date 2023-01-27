{
  lib,
  buildPythonPackage,
  pythonOlder,
  fetchFromGitHub,
  setuptools-scm,
  dvc-render,
  dvc-studio-client,
  ruamel-yaml,
}:
buildPythonPackage rec {
  pname = "dvclive";
  version = "1.3.3";
  format = "pyproject";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "iterative";
    repo = pname;
    rev = version;
    hash = "sha256-OnnXAQNRO+MovHCYHII/5M4ld5mApmCw3R5IJbPZDqY=";
  };

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    dvc-render
    dvc-render.optional-dependencies.table
    dvc-studio-client
    ruamel-yaml
  ];

  # Circular dependency with dvc
  doCheck = false;

  pythonImportsCheck = [
    "dvclive"
  ];

  meta = with lib; {
    description = "Library for logging machine learning metrics and other metadata in simple file formats";
    homepage = "https://github.com/iterative/dvclive";
    changelog = "https://github.com/iterative/scmrepo/releases/tag/${version}";
    license = licenses.asl20;
    maintainers = [];
  };
}
