{
  lib,
  buildPythonPackage,
  pythonOlder,
  fetchFromGitHub,
  setuptools-scm,
  pythonRelaxDepsHook,
  pydrive2,
  dvc-objects,
}:
buildPythonPackage rec {
  pname = "dvc-gdrive";
  version = "2.19.1";
  format = "pyproject";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "iterative";
    repo = pname;
    rev = version;
    hash = "sha256-iBiMnzo0VnP6CGcPGDXWDs6flKbSTAOilee4Ywr/N0M=";
  };

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
  nativeBuildInputs = [
    setuptools-scm
    pythonRelaxDepsHook
  ];

  pythonRemoveDeps = ["dvc"];

  propagatedBuildInputs =
    [
      pydrive2
      dvc-objects
    ]
    ++ pydrive2.optional-dependencies.fsspec;

  # Circular dependency with dvc
  doCheck = false;

  pythonImportsCheck = [
    "dvc_gdrive"
  ];

  meta = with lib; {
    description = "gdrive plugin for dvc";
    homepage = "https://github.com/iterative/dvc-gdrive";
    changelog = "https://github.com/iterative/dvc-gdrive/releases/tag/${version}";
    license = licenses.asl20;
    maintainers = [];
  };
}
