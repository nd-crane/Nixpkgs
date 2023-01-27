{
  lib,
  buildPythonPackage,
  pythonOlder,
  fetchFromGitHub,
  setuptools-scm,
  requests,
  appdirs,
  filelock,
  distro,
  pytest,
  pytest-sugar,
  pytest-cov,
  pytest-mock,
  pylint,
  mypy,
  types-requests,
}:
buildPythonPackage rec {
  pname = "iterative-telemetry";
  version = "0.0.6";
  format = "pyproject";
  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "iterative";
    repo = "telemetry-python";
    rev = version;
    hash = "sha256-ZZgXeX0uvV+4IzMw5z4l2XlI56+bRS4nB1EEpxdexMA=";
  };

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    requests
    appdirs
    filelock
    distro
  ];

  passthru = {
    optional-dependencies = {
      tests = [pytest pytest-sugar pytest-cov pytest-mock pylint mypy types-requests];
    };
  };

  meta = with lib; {
    description = "Version Control System for Machine Learning Projects";
    homepage = "https://dvc.org";
    changelog = "https://github.com/iterative/scmrepo/releases/tag/${version}";
    license = licenses.asl20;
    maintainers = [];
  };
}
