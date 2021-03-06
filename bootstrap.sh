#!/usr/bin/env bash 

# if apache2 does no exist
if [ ! -f /etc/apache2/apache2.conf ];
then
	
	#Mysql Password
	mysql_pwd="vagrant"

	apt-get update 
	apt-get install -y apache2

	# Install MySQL
	echo "mysql-server-5.1 mysql-server/root_password password $mysql_pwd" | debconf-set-selections
	echo "mysql-server-5.1 mysql-server/root_password_again password $mysql_pwd" | debconf-set-selections
	apt-get -y install mysql-client mysql-server-5.1

	# Install PHP5 support
	apt-get -y install php5 libapache2-mod-php5 php-apc php5-mysql php5-dev

	# Install PHP pear
	apt-get -y install php-pear

	# Install Symfony
	pear channel-discover pear.symfony-project.com
	pear install symfony/symfony-1.3.11

	# Add www-data to vagrant group
	usermod -a -G vagrant www-data

	# Restart services
	/etc/init.d/apache2 restart

	#Create link to www
	rm -rf /var/www
	ln -fs /vagrant /var/www

fi
