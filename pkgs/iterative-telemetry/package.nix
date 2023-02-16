{
  lib,
  buildPythonPackage,
  pythonOlder,
  fetchFromGitHub,
  # Dependencies
  setuptools-scm,
  requests,
  appdirs,
  filelock,
  distro,
  # Testing
  pytestCheckHook,
  pytest-sugar,
  pytest-cov,
  pytest-benchmark,
  pytest-mock,
  pylint,
  mypy,
  pytest-servers,
}:
buildPythonPackage rec {
  pname = "iterative-telemetry";
  version = "0.0.7";
  format = "pyproject";
  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "iterative";
    repo = "telemetry-python";
    rev = version;
    hash = "sha256-ZZgXeX0uvV+4IzMw5z4l2XlI56+bRS4nB1EEpxdexMA=";
  };

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
  nativeBuildInputs = [setuptools-scm];

  propagatedBuildInputs = [
    requests
    appdirs
    filelock
    distro
  ];

  nativeCheckInputs = [pytestCheckHook];

  checkInputs = [
    pytest-sugar
    pytest-cov
    pytest-benchmark
    pytest-mock
    pylint
    mypy
    pytest-servers
  ];

  pythonImportsCheck = ["iterative_telemetry"];

  disabledTests = [];
  disabledTestPaths = [];
  pytestFlagsArray = [];

  passthru = {
    optional-dependencies = {};
  };

  meta = with lib; {
    description = "Common library to send usage telemetry";
    homepage = "https://github.com/iterative/telemetry-python";
    changelog = "https://github.com/iterative/telemetry-python/releases/tag/${version}";
    license = licenses.asl20;
  };
}
