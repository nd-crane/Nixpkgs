{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools-scm,
  tabulate,
  matplotlib,
  # Docs
  # withDocs ? false,
  # Testing
  pytestCheckHook,
  funcy,
  pytest-sugar,
  pytest-cov,
  pytest-mock,
  pylint,
  mypy,
  pytest-test-utils,
}:
buildPythonPackage rec {
  pname = "dvc-render";
  version = "0.1.2";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "iterative";
    repo = pname;
    rev = version;
    hash = "sha256-dqwuZ47ldfTM3vWGCpYImiJHA/hdOVnPtf1yHmZRgeQ=";
  };

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
  nativeBuildInputs = [setuptools-scm];

  nativeCheckInputs = [pytestCheckHook];
  checkInputs =
    [
      funcy
      pytest-sugar
      pytest-cov
      pytest-mock
      pylint
      mypy
      pytest-test-utils
    ]
    ++ passthru.optional-dependencies.markdown;

  pythonImportsCheck = ["dvc_render"];

  passthru = {
    optional-dependencies = {
      table = [tabulate];
      markdown = [matplotlib] ++ passthru.optional-dependencies.table;
    };
  };

  meta = with lib; {
    description = "DVC's data management subsystem";
    homepage = "hhttps://github.com/iterative/dvc-data";
    license = licenses.asl20;
    maintainers = with maintainers; [];
  };
}
