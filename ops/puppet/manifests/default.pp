include apt 
apt::ppa{'ppa:brightbox/ruby-ng-experimental':}

class{'ruby':
    version         => '2.1.4',
    switch          => true,
    latest_release  => true,
    require         => Apt::Ppa['ppa:brightbox/ruby-ng-experimental'],
}
# class { 'rvm': version => '1.25.34' }
# rvm_system_ruby {
#   'ruby-2.1.4':
#     ensure      => 'present',
#     default_use => false;
# }