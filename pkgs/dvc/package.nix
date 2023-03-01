{
  lib,
  python3,
  fetchFromGitHub,
  withAzure ? false,
  withGoogleDrive ? false,
  withGoogleCloud ? false,
  withHDFS ? false,
  withAliyunOSS ? false,
  withS3 ? false,
  withSSH ? false,
  withSSHGSSAPI ? false,
  withWebDAV ? false,
  withHDFSWeb ? false,
  withHDFSWebKerberos ? false,
  withTerraform ? false,
}:
python3.pkgs.buildPythonApplication rec {
  pname = "dvc";
  version = "2.45.1";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "iterative";
    repo = pname;
    rev = version;
    hash = "sha256-1SdEpbWe/3Vis1nmcLmBWxrhj/1y9HPK3mj8QHdFiSE=";
  };

  postPatch = ''
    substituteInPlace dvc/daemon.py \
      --subst-var-by dvc "$out/bin/dcv"
  '';

  nativeBuildInputs = with python3.pkgs; [
    setuptools-scm
  ];

  propagatedBuildInputs = with python3.pkgs;
    [
      colorama
      configobj
      voluptuous
      requests
      grandalf
      distro
      appdirs
      ruamel-yaml
      tomlkit
      funcy
      pathspec
      shortuuid
      tqdm
      packaging
      zc_lockfile
      flufl_lock
      networkx
      psutil
      pydot
      importlib-resources
      flatten-dict
      tabulate
      pygtrie
      dpath
      shtab
      rich
      pyparsing
      typing-extensions
      scmrepo
      dvc-render
      dvc-task
      dvclive
      dvc-data
      dvc-http
      hydra-core
      iterative-telemetry
      dvc-studio-client
    ]
    ++ lib.optionals withAzure []
    ++ lib.optionals withGoogleDrive [
      dvc-gdrive
    ]
    ++ lib.optionals withGoogleCloud []
    ++ lib.optionals withHDFS []
    ++ lib.optionals withAliyunOSS []
    ++ lib.optionals withS3 []
    ++ lib.optionals withSSH []
    ++ lib.optionals withSSHGSSAPI []
    ++ lib.optionals withWebDAV []
    ++ lib.optionals withHDFSWeb []
    ++ lib.optionals withHDFSWebKerberos []
    ++ lib.optionals withTerraform []
    ++ lib.optionals (pythonOlder "3.9") [
      importlib-resources
    ];

  meta = with lib; {
    description = "Version Control System for Machine Learning Projects";
    homepage = "https://dvc.org";
    changelog = "https://github.com/iterative/dvc/releases/tag/${version}";
    license = licenses.asl20;
    maintainers = [];
  };
}
