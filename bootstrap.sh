#!/usr/bin/env bash

echo '------------------------------------'
echo '[1/4] Deleting temporary files'
echo '------------------------------------'
	mkdir -p /vagrant/temp
	mkdir -p /vagrant/log
	rm -rf /vagrant/temp/*
	rm -rf /vagrant/log/*
echo '------------------------------------'
echo '[2/4] Configuring php'
echo '------------------------------------'
	export DEBIAN_FRONTEND=noninteractive
	apt-get update > /dev/null
	echo "" | apt-get -y install php5-sqlite &> /dev/null
	/etc/init.d/apache2 restart > /dev/null
echo '------------------------------------'
echo '[3/4] Configuring mysql'
echo '------------------------------------'
	mkdir -p /vagrant/www/phpmyadmin > /dev/null
	rm -rf /vagrant/www/phpmyadmin/* > /dev/null
	cp -r /usr/share/phpmyadmin/* /vagrant/www/phpmyadmin/ &> /dev/null
	echo "create database teaching" | mysql -u debian-sys-maint -pAam1i2MGYHTwx3x6 > /dev/null
	mysql -u debian-sys-maint -pAam1i2MGYHTwx3x6 teaching < /vagrant/db/schema.sql > /dev/null
	mysql -u debian-sys-maint -pAam1i2MGYHTwx3x6 teaching < /vagrant/db/data.sql > /dev/null
echo '------------------------------------'
echo '[4/4] Configuring apache'
echo '------------------------------------'
	apt-get install vim > /dev/null
	cp /vagrant/.vagrant/vagrant_config/000-default.conf /etc/apache2/sites-available/000-default.conf
	cp /vagrant/.vagrant/vagrant_config/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
	cp /vagrant/.vagrant/vagrant_config/apache2.conf /etc/apache2/apache2.conf
	cp /vagrant/.vagrant/vagrant_config/hosts /etc/hosts > /dev/null
	/etc/init.d/apache2 restart > /dev/null
echo '------------------------------------'
echo 'FINISHED SUCCESSFULLY'
echo '------------------------------------'
