{
  buildPythonPackage,
  fetchFromGitHub,
  # Dependencies
  coverage,
}:
buildPythonPackage rec {
  pname = "coverage-enable-subprocess";
  version = "1.0";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "bukzor";
    repo = "python-${pname}";
    rev = "v${version}";
    hash = "sha256-YiFxss5M71hA0LE1ZAzP9RJnVzxOwp2lQheNhsZ4OsA=";
  };

  propagatedBuildInputs = [coverage];

  # No tests
  doCheck = false;

  meta = {
    description = "This package installs a pth file that enables the coveragepy process_startup feature in this python prefix/virtualenv in subsequent runs.";
    homepage = "https://github.com/bukzor/python-coverage-enable-subprocess";
  };
}
