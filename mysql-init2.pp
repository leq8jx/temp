### Global setttings
#Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

$mysql_password = hiera("rootpassword")
$db_name = hiera("dbname")
$db_user = hiera("dbuser")
$db_pass = hiera("dbpass")
$db_access = "192.168.%.%"

# install and configure mysql-server and configure it to listen on the network
class { '::mysql::server':
  root_password    => $mysql_password,
  override_options => { 'mysqld' => { 'bind-address' => $ipaddress_eth1 } }
}

# create the wordpress database and give permission to the wordpress user
mysql::db { $db_name:
  user     => $db_user,
  password => $db_pass,
  host     => $db_access,
  grant  => 'ALL',
}
