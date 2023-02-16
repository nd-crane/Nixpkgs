{
  lib,
  buildPythonPackage,
  pythonOlder,
  fetchFromGitHub,
  # Requirements
  setuptools-scm,
  google-api-python-client,
  oauth2client,
  pyopenssl,
  pyyaml,
  # fsspec optional
  fsspec,
  tqdm,
  funcy,
  appdirs,
}:
buildPythonPackage rec {
  pname = "pydrive2";
  version = "1.15.0";
  format = "pyproject";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "iterative";
    repo = pname;
    rev = version;
    hash = "sha256-V4zKtvsQXHso0DnQjy6v1L8U0CMe1JD/zm/2oWMKE5M=";
  };

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
  nativeBuildInputs = [setuptools-scm];

  propagatedBuildInputs = [
    google-api-python-client
    oauth2client
    pyopenssl
    pyyaml
  ];

  pythonImportsCheck = [
    "pydrive2"
  ];

  # Tests require google drive credentials
  doCheck = false;

  passthru = {
    optional-dependencies = {
      fsspec = [
        fsspec
        tqdm
        funcy
        appdirs
      ];
    };
  };

  meta = with lib; {
    description = "Google Drive API Python wrapper library";
    homepage = "https://github.com/iterative/PyDrive2";
    changelog = "https://github.com/iterative/PyDrive2/releases/tag/${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [sei40kr];
  };
}
