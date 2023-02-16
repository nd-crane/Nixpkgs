{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools-scm,
  # Dependencies
  pytest,
  requests,
  fsspec,
  universal-pathlib,
  filelock,
}:
buildPythonPackage rec {
  pname = "pytest-servers";
  version = "0.2.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "iterative";
    repo = pname;
    rev = version;
    hash = "sha256-esfaE5Q2HNNPJA3/aLGH+iHznGmgd2omiaN0zgkurdY=";
  };

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
  nativeBuildInputs = [setuptools-scm];

  propagatedBuildInputs = [
    pytest
    requests
    fsspec
    universal-pathlib
    filelock
  ];

  pythonImportsCheck = ["pytest_servers"];

  meta = with lib; {
    description = "";
    homepage = "https://github.com/iterative/pytest-servers";
    changelog = "https://github.com/iterative/pytest-servers/releases/tag/${version}";
    license = licenses.asl20;
  };
}
