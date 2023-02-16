{
  lib,
  buildPythonPackage,
  pythonOlder,
  fetchFromGitHub,
  # dependencies
  flit-core,
  fsspec,
  # Testing
  pytestCheckHook,
  aiohttp,
  adlfs,
  flake8,
  gcsfs,
  ipython,
  jupyter,
  moto,
  pyarrow,
  pylint,
  pytest,
  requests,
  s3fs,
  webdav4,
}:
buildPythonPackage rec {
  pname = "universal-pathlib";
  version = "0.0.21";
  format = "pyproject";
  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "fsspec";
    repo = "universal_pathlib";
    rev = "v${version}";
    hash = "sha256-l35fogLXUZKQHw/Y2E0mz7EO/hXFTSQdZ1wA9Ys83qs=";
  };

  nativeBuildInputs = [flit-core];

  propagatedBuildInputs = [
    fsspec
  ];

  nativeCheckInputs = [
    pytestCheckHook
    moto
  ];

  checkInputs = [
    aiohttp
    adlfs
    flake8
    gcsfs
    ipython
    jupyter
    moto
    pyarrow
    pylint
    pytest
    requests
    s3fs
    webdav4
  ];

  pythonImportsCheck = ["upath"];

  pytestFlagsArray = [
    # Disable tests that try to access the network
    "--deselect=upath/tests/implementations/test_http.py::test_httppath"
    "--deselect=upath/tests/implementations/test_http.py::test_httpspath"
  ];

  disabledTestPaths = [
    "upath/tests/implementations/test_s3.py"
    # Disable tests that require docker daemon
    "upath/tests/implementations/test_azure.py"
  ];

  passthru = {
    optional-dependencies = {};
  };

  meta = with lib; {
    description = "pathlib api extended to use fsspec backends";
    homepage = "https://github.com/fsspec/universal_pathlib";
    changelog = "https://github.com/fsspec/universal_pathlib/releases/tag/${version}";
    license = licenses.mit;
  };
}
