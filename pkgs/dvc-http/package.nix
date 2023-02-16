{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pythonOlder,
  setuptools-scm,
  pythonRelaxDepsHook,
  fsspec,
  aiohttp-retry,
  dvc-objects,
}:
buildPythonPackage rec {
  pname = "dvc-http";
  version = "2.30.1";
  format = "pyproject";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "iterative";
    repo = pname;
    rev = version;
    hash = "sha256-6dLzhXrZb6QmQzN9NKZOYzbfylJl90+N3qYnbsxlBgo=";
  };

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
  nativeBuildInputs = [
    setuptools-scm
    pythonRelaxDepsHook
  ];

  pythonRemoveDeps = ["dvc"];

  propagatedBuildInputs = [
    fsspec
    aiohttp-retry
    dvc-objects
  ];

  # Circular dependency with dvc
  doCheck = false;

  pythonImportsCheck = ["dvc_http"];

  meta = with lib; {
    description = "HTTP plugin for DVC";
    homepage = "https://github.com/iterative/dvc-http";
    changelog = "https://github.com/iterative/dvc-http/releases/tag/${version}";
    license = licenses.asl20;
  };
}
