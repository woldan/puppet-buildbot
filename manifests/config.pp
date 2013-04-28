define buildbot::config::master (
  $data_path,
  $python_env,
  $port
) {

  exec { "$data_path:create-master" :
    command => "buildbot create-master $data_path/master",
    cwd     => $data_path,
    creates => "$data_path/master/buildbot.tac",
    path    => [ "$python_env/bin", "/usr/bin", "/bin" ],
  }

  file { "$data_path/master/master.cfg" :
    ensure  => present,
    require => Exec["$data_path:create-master"],
    source => "$data_path/master/master.cfg.sample",
  }
}
