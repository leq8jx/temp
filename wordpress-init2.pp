### Global setttings
#Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

$db_name = hiera("dbname")
$db_user = hiera("dbuser")
$db_pass = hiera("dbpass")
$db_host = hiera("mysqlhost")

# install and configure apache server

class { 'apache':
  disableboot => false
}

# install mod-php for apache
apache::module { 'php5':
   install_package => 'libapache2-mod-php5',
}

# install the mysql-php module
class { 'php': }
php::module { 'mysql': }

# enable the php module on apache unless already enabled
#exec { "enable-php-module":
#	command => "sudo a2enmod php5",
#	unless => "sudo a2enmod -q php5",
#	require => Package["apache2-mod_php5"],
#	notify => Service["apache2"],
#}

class { 'wordpress':
  db_name     => "$db_name",
  db_user        => "$db_user",
  db_password    => "$db_pass",
  create_db      => false,
  create_db_user => false,
  install_dir => '/var/www/html/wp',
  db_host => "$db_host"
}
