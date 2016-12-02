wordpress::instance { '/opt/wordpress1':
  db_user     => hiera("dbuser"),
  db_password => hiera("dbpass"),
  db_host     => hiera("mysqlhost"),
}
