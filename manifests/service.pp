define buildbot::service::master (
  $data_path,
  $python_env,
) {

  service { "buildbot:$data_path/master" :
    provider => "base",
    ensure   => running,
    start    => "$python_env/bin/buildbot start $data_path/master",
    restart  => "$python_env/bin/buildbot restart $data_path/master",
    stop     => "$python_env/bin/buildbot stop $data_path/master",
    status   => "$python_env/bin/buildbot statuslog $data_path/master",
  }

}
