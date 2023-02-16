{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools-scm,
  funcy,
  dictdiffer,
  pygtrie,
  shortuuid,
  dvc-objects,
  diskcache,
  nanotime,
  attrs,
  sqltrie,
  # CLI
  typer,
  rich,
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
  pname = "dvc-data";
  version = "0.40.3";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "iterative";
    repo = "dvc-data";
    rev = version;
    hash = "sha256-kJABNVUFoaN8Q7IVJKW/LF2kJwB4HcsvMEDmE6eTAxg=";
  };

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
  nativeBuildInputs = [setuptools-scm];

  propagatedBuildInputs = [
    funcy
    dictdiffer
    pygtrie
    shortuuid
    dvc-objects
    diskcache
    nanotime
    attrs
    sqltrie
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

  pythonImportsCheck = ["dvc_data"];

  disabledTestPaths = [
    # Disable tests that require s3 server
    "tests/hashfile/test_istextfile.py"
    # Disable benchmark tests
    "tests/benchmarks/test_checkout.py"
  ];

  passthru = {
    optional-dependencies = {
      cli = [typer rich];
    };
  };

  meta = with lib; {
    description = "DVC's data management subsystem";
    homepage = "https://github.com/iterative/dvc-data";
    changelog = "https://github.com/iterative/dvc-data/releases/tag/${version}";
    license = licenses.asl20;
  };
}
