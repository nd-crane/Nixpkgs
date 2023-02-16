{
  lib,
  buildPythonPackage,
  pythonOlder,
  fetchFromGitHub,
  setuptools-scm,
  celery,
  kombu,
  funcy,
  shortuuid,
  pytest-celery,
  pytest-mock,
  pytest-test-utils,
  pytestCheckHook,
}:
buildPythonPackage rec {
  pname = "dvc-task";
  version = "0.1.11";
  format = "pyproject";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "iterative";
    repo = pname;
    rev = version;
    hash = "sha256-0KfH0/rghq+03sFLaR8lsIi4TJuwwca/YhQgILCdHq8=";
  };

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
  nativeBuildInputs = [setuptools-scm];

  propagatedBuildInputs = [
    celery
    kombu
    funcy
    shortuuid
  ];

  checkInputs = [
    pytest-celery
    pytest-mock
    pytest-test-utils
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "dvc_task"
  ];

  meta = with lib; {
    description = "Celery task queue used in DVC";
    homepage = "https://github.com/iterative/dvc-task";
    changelog = "https://github.com/iterative/scmrepo/releases/tag/${version}";
    license = licenses.asl20;
    maintainers = [];
  };
}
