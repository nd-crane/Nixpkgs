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
  version = "0.19.3";
  format = "pyproject";
  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "iterative";
    repo = pname;
    rev = version;
    hash = "sha256-oKK+BhOgdRPZZAACgxgmr9rlzEH9yWmvbmx09d42u/Y=";
  };

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
  nativeBuildInputs = [setuptools-scm];

  propagatedBuildInputs = [
    tqdm
    shortuuid
    funcy
    fsspec
    typing-extensions
  ];

  nativeCheckInputs = [pytestCheckHook];
  checkInputs = [
    pytest-sugar
    pytest-cov
    pytest-mock
    pylint
    mypy
  ];

  pythonImportsCheck = ["dvc_objects"];

  meta = with lib; {
    description = "Library for DVC objects";
    homepage = "https://github.com/iterative/dvc-objects";
    changelog = "https://github.com/iterative/dvc-objects/releases/tag/${version}";
    license = licenses.asl20;
  };
}
