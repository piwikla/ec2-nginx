#!/bin/bash

#https://github.com/piwikla/ec2-nginx

#Update
yum update

#Installing Packages
yum install nginx php-fpm php-xml php-pdo php-odbc \
  php-soap php-common php-cli php-mbstring php-bcmath php-ldap \
  php-imap php-gd php-pecl-apc
yum install mysql-server mysql php-mysql 
yum install postgresql-server postgresql php-pgsql
  

#Chkconfig and primary configuration
chkconfig nginx on
chkconfig mysqld on
chkconfig php-fpm on

service mysqld start
mysql_secure_installation

#Start Nginx
service php-fpm start
service nginx start
