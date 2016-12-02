$user = hiera("dbuser")
$host = hiera("wphost")
$dbname = hiera("dbname")
$dbuserathost = "${user}@${wphost}"

class { '::mysql::server':
  root_password           => hiera("rootpassword"),
  remove_default_accounts => true,
  override_options        => {
    mysqld => {
      bind-address => '0.0.0.0',
    },
  },
  users => {
    $dbuserathost => {
      ensure                   => 'present',
      max_connections_per_hour => '0',
      max_queries_per_hour     => '0',
      max_updates_per_hour     => '0',
      max_user_connections     => '0',
      password_hash            => hiera("dbpasshash"),
      tls_options              => ['NONE'],
    },
  },
  grants                  => {
    "${dbuserathost}/${dbname}.*" => {
      ensure     => 'present',
      options    => ['GRANT'],
      privileges => ['ALL'],
      table      => "${dbname}.*",
      user       => $dbuserathost,
    },
  },
}

mysql::db { hiera("dbname"):
  user     => hiera("dbuser"),
  password => hiera("dbpass"),
  host     => hiera("dbhost"),
  grant    => ['ALL'],
}
