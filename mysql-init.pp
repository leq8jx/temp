class { '::mysql::server':
  root_password           => 'rootpassword',
  remove_default_accounts => true,
}

mysql::db { hiera("dbtable"):
  user     => hiera("dbuser"),
  password => hiera("dbpass"),
  host     => hiera("dbhost"),
  grant    => ['SELECT', 'UPDATE'],
}
