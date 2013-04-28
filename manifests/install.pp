define buildbot::install(
  $data_path,
  $python_env
) {

  file { $data_path :
    ensure  => directory,
    mode    => "777",
  }

  class { 'python' :
    version => 'system',
    dev     => true,
    virtualenv => true,
  }
  python::virtualenv { $python_env :
    require => Class['python'],
    ensure => present,
    version => 'system',
    systempkgs => false,
  }

  # Work around incompatibility sqlalchemy / sqlalchemy_migrate [fixed in buildbot upstream becoming 0.8.8]:
  $sqlalchemy  = "sqlalchemy==0.7.10"

  python::pip { $sqlalchemy :
    virtualenv => $python_env,
  }
  python::pip { [ "buildbot", "buildbot-slave" ] :
    require    => Python::Pip[$sqlalchemy],
    virtualenv => $python_env,
  }
}
