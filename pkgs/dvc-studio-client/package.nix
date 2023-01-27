{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pythonOlder,
  setuptools-scm,
  gitpython,
  requests,
  voluptuous,
}:
buildPythonPackage rec {
  pname = "dvc-studio-client";
  version = "0.3.0";
  format = "pyproject";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "iterative";
    repo = pname;
    rev = version;
    hash = "sha256-LSehY7dIi7UEZim60X0660WzaZp1VuALcxxNCP7Quuk=";
  };

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    gitpython
    requests
    voluptuous
  ];

  # Circular dependency with dvc
  doCheck = false;

  pythonImportsCheck = [
    "dvc_studio_client"
  ];

  meta = with lib; {
    description = "Library for logging machine learning metrics and other metadata in simple file formats";
    homepage = "https://github.com/iterative/dvclive";
    changelog = "https://github.com/iterative/scmrepo/releases/tag/${version}";
    license = licenses.asl20;
    maintainers = [];
  };
}
