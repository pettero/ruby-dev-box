include apt 
apt::ppa{'ppa:brightbox/ruby-ng-experimental':}
package{[
  'sqlite3',
  'libsqlite3-dev',
  'nodejs',
  ]:
}
class{'ruby':
    version         => '2.0.0',
    switch          => true,
    latest_release  => true,
    require         => Apt::Ppa['ppa:brightbox/ruby-ng-experimental'],
}
class{'ruby::dev' : }

ruby::bundle { '/opt/www/RestAPI': 
  path => '/opt/www/RestAPI',
  cwd  => '/opt/www/RestAPI',
}

unicorn::app { 'rest-api':
  approot     => '/opt/www/RestAPI',
  pidfile     => '/opt/www/RestAPI/unicorn.pid',
  socket      => '/tmp/unicorn.RestAPI.sock',
  preload_app => true,
  rack_env    => 'development',
  source      => 'bundler',
  require     => [
    Class['ruby::dev'],
    Ruby::Bundle['/opt/www/RestAPI'],
  ],
}

class { 'nginx': }
nginx::resource::vhost { 'app.local':
  proxy => 'unix:/tmp/unicorn.RestAPI.sock',
}
# class { 'rvm': version => '1.25.34' }
# rvm_system_ruby {
#   'ruby-2.1.4':
#     ensure      => 'present',
#     default_use => false;
# }