{
  lib,
  buildPythonPackage,
  pythonOlder,
  fetchFromGitHub,
  setuptools-scm,
  tqdm,
  shortuuid,
  funcy,
  fsspec,
  typing-extensions,
  pytestCheckHook,
  pytest-sugar,
  pytest-cov,
  pytest-mock,
  pylint,
  mypy,
}:
buildPythonPackage rec {
  pname = "dvc-objects";
  version = "0.19.0";
  format = "pyproject";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "iterative";
    repo = pname;
    rev = version;
    hash = "sha256-jwjhRY1SMqiTZ5UJmoZb4odg3g8uC9ehPmxRU2VsH8U=";
  };

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    tqdm
    shortuuid
    funcy
    fsspec
    typing-extensions
  ];

  checkInputs = [
    pytestCheckHook
    pytest-sugar
    pytest-cov
    pytest-mock
    pylint
    mypy
  ];

  pythonImportsCheck = [
    "dvc_objects"
  ];

  meta = with lib; {
    description = "Library for DVC objects";
    homepage = "https://github.com/iterative/dvc-objects";
    changelog = "https://github.com/iterative/scmrepo/releases/tag/${version}";
    license = licenses.asl20;
    maintainers = [];
  };
}
