class { 'rvm': version => '1.25.34' }
rvm_system_ruby {
  'ruby-2.1.4':
    ensure      => 'present',
    default_use => false;
}