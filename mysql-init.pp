class { '::mysql::server':
  root_password           => 'rootpassword',
  remove_default_accounts => true,
  override_options        => $override_options,
}

$override_options = {
  'mysqld' => {
    'bind-address' => '0.0.0.0',
  }
}

mysql::db { hiera("dbtable"):
  user     => hiera("dbuser"),
  password => hiera("dbpass"),
  host     => hiera("dbhost"),
  grant    => ['SELECT', 'UPDATE'],
}
