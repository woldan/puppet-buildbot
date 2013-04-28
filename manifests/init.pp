define buildbot(
  $data_path,
  $python_env,
  $port = 8010
) {

  buildbot::install { $data_path :
    data_path  => $data_path,
    python_env => $python_env,
  }

  buildbot::config::master { $data_path :
    require    => Buildbot::Install[$data_path],
    data_path  => $data_path,
    python_env => $python_env,
    port       => $port,
  }

  buildbot::service::master { $data_path :
    require    => Buildbot::Config::Master[$data_path],
    data_path  => $data_path,
    python_env => $python_env,
  }

}
