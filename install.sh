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

#config nginx
cp /etc/nginx/conf.d/virtual.conf /etc/nginx/sites-available/piwik.la
ln -s /etc/nginx/sites-available/piwik.la /etc/nginx/sites-enabled
rm /etc/nginx/sites-enabled/default

#download piwik
mkdir -p /home/piwik/public_html/piwik.la
cd /home/piwik/public_html/piwik.la
wget http://piwik.org/latest.zip && unzip latest.zip
cd piwik
mv * ../
cd ../
rm -rf piwik

#Start Nginx
service php-fpm start
service nginx start
