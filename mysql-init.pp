class { '::mysql::server':
  root_password           => 'rootpassword',
  remove_default_accounts => true,
  override_options        => {
    mysqld => {
      bind-address => '0.0.0.0',
    },
  },
  users => {
    'wordpressuser@192.168.153.143' => {
      ensure                   => 'present',
      max_connections_per_hour => '0',
      max_queries_per_hour     => '0',
      max_updates_per_hour     => '0',
      max_user_connections     => '0',
      password_hash            => '*CF203ECFFF6DECCDF3155C37B67E906A0F45CBF7',
      tls_options              => ['NONE'],
    },
  },
  grants                  => {
    'wordpressuser@192.168.153.143/wordpresstable.*' => {
      ensure     => 'present',
      options    => ['GRANT'],
      privileges => ['ALL'],
      table      => 'wordpresstable.*',
      user       => 'wordpressuser@192.168.153.143',
    },
  },
}

mysql::db { hiera("dbtable"):
  user     => hiera("dbuser"),
  password => hiera("dbpass"),
  host     => hiera("dbhost"),
  grant    => ['ALL'],
}
