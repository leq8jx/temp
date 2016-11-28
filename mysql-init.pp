class { '::mysql::server':
  root_password           => 'rootpassword',
  remove_default_accounts => true,
}

mysql::db { 'wordpress':
  user     => 'wordpress',
  password => 'wordpress',
  host     => localhost,
  grant    => ['SELECT', 'UPDATE'],
}
