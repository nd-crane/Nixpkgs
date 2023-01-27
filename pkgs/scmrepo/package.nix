{
  lib,
  buildPythonPackage,
  pythonOlder,
  fetchFromGitHub,
  setuptools-scm,
  gitpython,
  dulwich,
  pygit2,
  pygtrie,
  fsspec,
  pathspec,
  asyncssh,
  funcy,
}:
buildPythonPackage rec {
  pname = "scmrepo";
  version = "0.1.6";
  format = "pyproject";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "iterative";
    repo = pname;
    rev = version;
    hash = "sha256-qSD8FsaJ0wZ8h0mO6qge3Q5fKIbMrONvJraprKVoNDE=";
  };

  SETUPTOOLS_SCM_PRETEND_VERSION = version;
  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    gitpython
    dulwich
    pygit2
    pygtrie
    fsspec
    pathspec
    asyncssh
    funcy
  ];

  # Requires a running Docker instance
  doCheck = false;

  pythonImportsCheck = [
    "scmrepo"
  ];

  meta = with lib; {
    description = "SCM wrapper and fsspec filesystem";
    homepage = "https://github.com/iterative/scmrepo";
    changelog = "https://github.com/iterative/scmrepo/releases/tag/${version}";
    license = licenses.asl20;
    maintainers = [];
  };
}
